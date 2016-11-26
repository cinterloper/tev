import groovy.json.JsonOutput 
mtbl = [:]

def clazz = this.class.classLoader.loadClass(args[0])

clazz.getMethods().each { m -> 
  def p = m.getParameterTypes()
  def ps = []
  p.each { Class c ->
    ps += c.getName()
  }
  mtbl[m.getName()]=ps
}
println(JsonOutput.toJson(mtbl))

