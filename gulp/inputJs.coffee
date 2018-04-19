import dd from 'ddeyes'

# import Fs from 'fs'
import Path from 'path'
# import del from 'del'
# import omit from 'omit'

import Vinyl from 'vinyl'
import through from 'through2'

export default (config) =>

  stream = through.obj (file, enc, cb) =>

    # buf = Buffer.from file._contents
    # fileStr = buf.toString enc

    # dd omit [ '_contents' ], file
    # dd file.history[0]
    # dd file.base

    baseFile = (
      file.history[0].replace file.base, ''
    ).replace '.coffee', '.js'

    deployFile = "./build/#{baseFile}"
    baseName = Path.basename deployFile, '.js'
    baseDir = baseFile.replace "#{baseName}.js", ''
    prefixBaseDir = [0..(
      baseFile.split '/'
    ).length].reduce (r, c) =>
      return r if c is 0
      "#{r}../"
    , ''
    # main = ->
    #   r = hello()
    #   if r.isItem? and r.isItem()
    #   then r.getItem()
    #   else r
    template = """
      import #{baseName} from '#{prefixBaseDir}example/#{baseDir}#{baseName}.coffee';
      var main;
      main = function() {
        var r;
        r = #{baseName}();
        if ((r.isItem != null) && r.isItem()) {
          return r.getItem();
        } else {
          return r;
        }
      };
      main();
    """

    # unless Fs.existsSync "./build/#{baseDir}"
    #   Fs.mkdirSync "./build/#{baseDir}"
    # else if Fs.existsSync deployFile
    #   del.sync deployFile
    # Fs.writeFileSync deployFile, template, 'utf-8'

    cb null
    ,
      new Vinyl
        cwd: file.cwd
        base: undefined
        path: baseFile
        contents: new Buffer template 
 
  stream
