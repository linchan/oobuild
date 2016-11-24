var path = require('path');
var VERSON = '3.2.9';
var viewPath = 'E:/project/vvic/branches/website/'+VERSON+'/vvic-control/src/main/webapp';
var srcPath = 'E:/project/vvic/branches/website/'+VERSON+'/vvic-frontend/statics/build/v3';
var distPath = 'E:/project/vvic/branches/website/'+VERSON+'/vvic-frontend/statics/v3';

module.exports = {
    srcPath: srcPath,
    distPath: distPath,
    // webpack任务
    webpack: {
        src: srcPath + '/js',
        libSrc: path.join(srcPath, '../../lib'),
        jsDest: distPath + '/js/dist'
    },

    // views任务
    views: {
        pagesSrc: srcPath + '/template/view/**/**/*',
        staticSrc: srcPath + '/template/static/*.html',
        dest: viewPath + '/WEB-INF/view'
    },

    // images任务
    images: {
        src: [
            srcPath + '/images/**/*+(jpg|jpeg|png|gif|svg)'
        ],
        dest: distPath + '/css/img'
    },

    // sprites任务
    sprites: {
        src: srcPath + '/sprite',
        lessDest: srcPath + '/less/sp',
        imgDest: distPath + '/css/sp'
    },

    // less任务
    css: {
        src: [path.join(srcPath, '/less/*.less'), '!'+path.join(srcPath,'/less/_*.less')],
        dest: distPath + '/css'
    }
};
