import net.iowntheinter.kvdn.service.kvsvc
import groovy.json.JsonOutput 
mtbl = [:]
kvsvc.getMethods().each { m -> 
  def p = m.getParameterTypes()
  def ps = []
  p.each { Class c ->
    ps += c.getName()
  }
  mtbl[m.getName()]=ps
}
println(JsonOutput.toJson(mtbl))

