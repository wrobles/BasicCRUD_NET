var myApp = angular.module('appUsuarios', []);

myApp.controller('controllerUsuarios', ['$scope', function ($scope) {
    /*$scope.alumnos = [
	{ nombre: "Juan Blanco", telefono: "1111111111", curso: "Angular" },
	{ nombre: "Alberto Herrera", telefono: "2222222222", curso: "Angular" },
	{ nombre: "Bernardo Bermudez", telefono: "5555555555", curso: "Node" },
	{ nombre: "Ana Marino", telefono: "3333333333", curso: "Node" },
	{ nombre: "David Elisondo", telefono: "7777777777", curso: "LESS" },
	{ nombre: "Alicia Arellano", telefono: "4444444444", curso: "Node" },
	{ nombre: "Carlonia Duarte", telefono: "6666666666", curso: "LESS" }
    ]*/

    $scope.formaVisibilidad = false;
    $scope.titulo = "Agregar";

    $scope.Guardar = function () {
        //$scope.alumnos.push({ nombre: $scope.nuevoAlumno.nombre, telefono: $scope.nuevoAlumno.telefono, curso: $scope.nuevoAlumno.curso })
        //$scope.formaVisibilidad = false;
        $scope.nuevoAlumno.nombre = "";
        $scope.nuevoAlumno.telefono = "";
        $scope.nuevoAlumno.curso = "";
    };

    $scope.MostrarFormulario = function () {
        $scope.formaVisibilidad = true;
    }

    $scope.OcultarFormulario = function () {
        $scope.formaVisibilidad = false;
    }

}]);