import prettier from 'prettier'

import Vinyl from 'vinyl'
import through from 'through2'

export default (config) =>

  stream = through.obj (file, enc, cb) =>

    buf = Buffer.from file._contents
    fileStr = buf.toString enc

    cb null
    ,
      new Vinyl
        cwd: file.cwd
        base: file.base
        path: file.history[0]
        contents: new Buffer prettier.format fileStr

  stream
