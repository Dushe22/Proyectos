//Variables Prompt para que el usuario pueda ingresar su informacion personal y del curso
var NombreAlumno = prompt('Ingrese su nombre:');
var ApellidoAlumno = prompt('Ingrese su apellido:');
var DepartamentoAlumno = prompt('Ingrese su departamento o localidad:');
var PuntajeFundamentos = prompt('Ingrese su puntaje de la evaluacion de Fundamentos: ')
var PuntajeImperativa = prompt('Ingrese su puntaje de la evaluacion de Imperativa:');
var PuntajeObjetos = prompt('Ingrese su puntaje de la evaluacion de Objetos:');
var CompetenciasTransversales = prompt('Entre 1 y 10, Cuantas tareas de CT realizo: ')
var PuntajeIngles1 = prompt('Ingrese su puntaje de la primer actividad de ingles:');
var PuntajeIngles2 = prompt('Ingrese su puntaje de la segunda actividad de ingles:');
var PuntajeIngles3 = prompt('Ingrese su puntaje de la tercera actividad de ingles:');
var Evidencias = prompt('Ingrese la cantidad de evidencias entregadas (Entre 1 y 3):')

 
 
 //Registro de datos basados en el prompt anterior que sera usado en la funcion final
 let datosPersona = {
    nombre : NombreAlumno,
    apellido : ApellidoAlumno,
    depto : DepartamentoAlumno,
    puntaEvalua: PuntajeEvaluaciones,
    compTrans: CompetenciasTransversales,
    promIngles: PromedioIngles,
    evidencia: Evidencias
};


   var PromedioIngles = (Number(PuntajeIngles1) + Number(PuntajeIngles2) + Number(PuntajeIngles3))/3 //Promedio Ingles

   var PuntajeEvaluaciones = (Number(PuntajeFundamentos) * 0.3) + (Number(PuntajeImperativa) * 0.5) + (Number(PuntajeObjetos) * 0.2) //Puntaje Evaluaciones
    
   function EvidenciasRealizadas(){ //Entrega de Evidencias
    if (Evidencias < 3){
        return false
    }
    else return true
   }

   function transversales(){//Competencias Transversales
    if (CompetenciasTransversales<10){
    return false;
    }else{
        return true;
}
}
//Funcion final que devuelve los datos y resultados en consola de acuerdo a los puntajes obtenidos durante el curso
function DevolucionFinal(datosPersona){
    if ((PromedioIngles >= 50) && (transversales() == true) && (PuntajeEvaluaciones >= 60) && (EvidenciasRealizadas() == true)) {
        return ('Hola! Alumno: ' + datosPersona.nombre + ' ' + datosPersona.apellido + ' Localidad: ' + datosPersona.depto + ' Tus puntajes son... ' + ' En Ingles: ' + (Math.round (PromedioIngles)) + ' [Completaste Transversales] ' + ' [Entregaste todas las evidencias] ' + ' Aprobado con: ' + PuntajeEvaluaciones );}

    
     if ((PromedioIngles < 50) || (transversales() == false) || ((PuntajeEvaluaciones < 50) || (EvidenciasRealizadas() == false))){
        return ('Hola! Alumno: ' + datosPersona.nombre + ' ' + datosPersona.apellido + ' Localidad: ' + datosPersona.depto + ' Tus puntajes son... ' + ' En Ingles: ' + (Math.round (PromedioIngles)) + ' [No Completaste Transversales] ' + ' [No Entregaste todas las evidencias]  ' + ' Reprobado con: ' + PuntajeEvaluaciones );}
    
    
    else ((PromedioIngles >= 50) && (transversales() == true) && ((PuntajeEvaluaciones >50) && (PuntajeEvaluaciones <60) || (EvidenciasRealizadas() == false))); {
        return ('Hola! Alumno: ' + datosPersona.nombre + ' ' + datosPersona.apellido + ' Localidad: ' + datosPersona.depto + ' Tus puntajes son... ' + ' En Ingles: ' + (Math.round (PromedioIngles)) + ' [Completaste Transversales] ' + ' [Entregaste todas las evidencias] ' + 'A examen reglamentario con: ' + PuntajeEvaluaciones );}
        
    }
    console.log (DevolucionFinal(datosPersona))