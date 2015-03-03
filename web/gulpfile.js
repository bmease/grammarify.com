var path = require('path');
var gulp = require('gulp');
var gutil = require('gulp-util');

var source = require('vinyl-source-stream');
var browserify = require('browserify');
var watchify = require('watchify');
var livereload = require('gulp-livereload');

var sass = require('gulp-sass');
var neat = require('node-neat');
var autoprefixer = require('autoprefixer')
var postcss = require('gulp-postcss');
var atImport = require('postcss-import');

var DEBUG = false;

var paths = {
    scripts: {
        entries: ['./static/scripts/src/application.coffee'],
        dest: './static/scripts/lib/',
        destFilename: 'application.min.js'
    },

    styles: {
        src: './static/styles/src/**/*.scss',
        entries: ['./static/styles/src/application.scss'],
        dest: './static/styles/lib/',
        destFilename: 'application.css'
    }
};


function bundle(method) {
    if (method === undefined) method = browserify;

    return method({
            paths: ['./static/scripts/src/'],
            entries: paths.scripts.entries,
            extensions: ['.coffee', '.hbs']
        })
}

function buildJS(bundle) {
    if (!DEBUG) {
        bundle.transform({ global: true }, 'uglifyify');
    }

    return bundle.bundle()
        .pipe(source(paths.scripts.destFilename))
        .pipe(gulp.dest(paths.scripts.dest))
}

function logChangedFiles(files) {
    if (files) {
        filenames = [];
        files.forEach(function(file) {
            filename = path.basename(file);
            filenames.push(filename);
        });
        gutil.log('Changes detected in', gutil.colors.yellow(filenames.join(', ')));
    }
}


gulp.task('scripts', function() {
    return buildJS(bundle());
});

gulp.task('watch', function() {

        // Watch styles
        livereload.listen()
        gulp.watch(paths.styles.src, ['styles'])
            .on('change', livereload.changed);

        // Watch scripts
        // bundler = bundle(watchify);

        b = browserify({
            paths: ['./static/scripts/src/'],
            entries: paths.scripts.entries,
            extensions: ['.coffee', '.hbs'],
            cache: {},
            packageCache: {},
            fullPaths: true
        });

        bundler = watchify(b);

        bundler.on('update', rebundle);

        function rebundle(files) {

            logChangedFiles(files);

            return buildJS(bundler)
                .pipe(livereload())
        }

        return rebundle()
});

gulp.task('styles', function() {
    var processors = [
        // Inline css files that are included in sass
        // e.g. normalize.css
        atImport({ path: ['node_modules'] }),

        // Add vendor prefixes
        autoprefixer({ cascade: false }).postcss,

    ];

    // Compress css
    // if (!DEBUG) {
    //     // FIXME: csswring messes up css
    //     //processors.push(csswring.postcss);
    // }

    var includePaths = neat.with(paths.styles.entries);

    return gulp.src(paths.styles.entries)
        .pipe(sass({
            includePaths: includePaths,
            // onError: function(error) { return notify().write(error); }
        }))
        .pipe(postcss(processors))
        .pipe(gulp.dest(paths.styles.dest))
});

gulp.task('default', ['scripts', 'styles']);
