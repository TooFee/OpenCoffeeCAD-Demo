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
    template = """
      import #{baseName} from '#{prefixBaseDir}example/#{baseDir}#{baseName}.coffee';
      function main() { return #{baseName}(); };
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
