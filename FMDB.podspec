Pod::Spec.new do |s|
  s.name = 'FMDB'
  s.version = '2.5'
  s.summary = 'A Cocoa / Objective-C wrapper around SQLite.'
  s.homepage = 'https://github.com/ccgus/fmdb'
  s.license = 'MIT'
  s.author = { 'August Mueller' => 'gus@flyingmeat.com' }
  s.source = { :git => 'https://github.com/ccgus/fmdb.git', :tag => 'v2.5' }
  s.requires_arc = true

  s.default_subspec = 'standard'

  s.subspec 'common' do |ss|
    ss.source_files = 'src/fmdb/FM*.{h,m}'
    ss.private_header_files = 'src/fmdb/*Private.h'
    ss.exclude_files = 'src/fmdb.m'
  end

  # use the built-in library version of sqlite3
  s.subspec 'standard' do |ss|
    ss.library = 'sqlite3'
    ss.dependency 'FMDB/common'
  end

  # use the built-in library version of sqlite3 with custom FTS tokenizer source files
  s.subspec 'FTS' do |ss|
    ss.source_files = 'src/extra/fts3/*.{h,m}'
    ss.dependency 'FMDB/standard'
    ss.private_header_files = 'src/extra/fts3/fts3_tokenizer.h'
  end

  # use a custom built version of sqlite3
  s.subspec 'standalone' do |ss|
    ss.dependency 'FMDB/common'
    end

  # use SQLCipher and enable -DSQLITE_HAS_CODEC flag
  s.subspec 'SQLCipher' do |ss|
    ss.dependency 'SQLCipher'
    ss.dependency 'FMDB/common'
    ss.xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_HAS_CODEC' }
  end
  
end
