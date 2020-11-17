
require 'fileutils'

def op(base, name, desc, &block)
  `git checkout -b #{name} #{base}`
  yield block
  `git add -A`
  `git commit -m "#{desc}"`
end

def i(name, desc, &block)
  op("master", "#{name}_init", desc, &block)
end

def o(name, desc, &block)
  op("#{name}_init", "#{name}_our", "#{desc} our", &block)
end

def t(name, desc, &block)
  op("#{name}_init", "#{name}_their", "#{desc} their", &block)
end

def c(path, data)
  File.open("#{path}.txt", "w") { |file| file.puts data }
end

def r(src, dst)
  FileUtils.mv("#{src}.txt", "#{dst}.txt")
end

def u(path, data)
  File.open("#{path}.txt", "a") { |file| file.puts data }
end

def d(path)
  File.delete("#{path}.txt")
end

octc="our create, their create."
i(:octc, octc) { }
o(:octc, octc) { c("octc", octc + "o") }
t(:octc, octc) { c("octc", octc + "t") }

octr="our create, their rename."
i(:octr, octr) { c("octr.i", octr + "i") }
o(:octr, octr) { c("octr.o", octr + "o") }
t(:octr, octr) { r("octr.i", "octr.o") }

outu="our update, their update."
i(:outu, outu) { c("outu.i", outu + "i") }
o(:outu, outu) { u("outu.i", outu + "o") }
t(:outu, outu) { u("outu.i", outu + "t") }

outr="our update, their rename."
i(:outr, outr) { c("outr.i", outr + "i") }
o(:outr, outr) { u("outr.i", outr + "o") }
t(:outr, outr) { r("outr.i", "outr.t") }

outd="our update, their delete."
i(:outd, outd) { c("outd.i", outd + "i") }
o(:outd, outd) { u("outd.i", outd + "o") }
t(:outd, outd) { d("outd.i") }

ortc="our rename, their create."
i(:ortc, ortc) { c("ortc.i", ortc + "i") }
o(:ortc, ortc) { r("ortc.i", "ortc.o") }
t(:ortc, ortc) { c("ortc.o", ortc + "t") }

ortu="our rename, their update."
i(:ortu, ortu) { c("ortu.i", ortu + "i") }
o(:ortu, ortu) { r("ortu.i", "ortu.o") }
t(:ortu, ortu) { u("ortu.i", ortu + "t") }

ortr="our rename, their rename."
i(:ortr, ortr) { c("ortr.i", ortr + "i") }
o(:ortr, ortr) { r("ortr.i", "ortr.o") }
t(:ortr, ortr) { r("ortr.i", "ortr.t") }

ortd="our rename, their delete."
i(:ortd, ortd) { c("ortd.i", ortd + " i") }
o(:ortd, ortd) { r("ortd.i", "ortd.o") }
t(:ortd, ortd) { d("ortd.i") }

odtu="our delete, their update."
i(:odtu, odtu) { c("odtu.i", odtu + "i") }
o(:odtu, odtu) { d("odtu.i") }
t(:odtu, odtu) { u("odtu.i", odtu + "t") }

odtr="our delete, their rename."
i(:odtr, odtr) { c("odtr.i", odtr + "i") }
o(:odtr, odtr) { d("odtr.i") }
t(:odtr, odtr) { r("odtr.i", "ortc.t") }

odtd="our delete, their delete."
i(:odtd, odtd) { c("odtd.i", odtd + "i") }
o(:odtd, odtd) { d("odtd.i") }
t(:odtd, odtd) { d("odtd.i") }
