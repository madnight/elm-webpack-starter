var gulp = require('gulp')
var htmlmin = require('gulp-htmlmin')
var ghPages = require('gulp-gh-pages')
var confirm = require('inquirer-confirm')

gulp.task('deploy', () => {
  confirm('are you sure you want to deploy to gh-pages').then(() => {
    return gulp.src('./dist/**/*')
    .pipe(ghPages())
  }, () => {
    console.log('deploy aborted')
  })
})

gulp.task('minify', () => {
  return gulp.src('./dist/**/*.html')
    .pipe(htmlmin({collapseWhitespace: true}))
    .pipe(gulp.dest('public'))
})
