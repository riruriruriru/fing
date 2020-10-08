require 'faker'

#faker tutors

2.times do |i|
	Tutor.create(rut: Faker::Number.number(digits: 9),
			     firstname:Faker::Name.first_name,
			     lastname:Faker::Name.last_name,
			     email:Faker::Internet.email,
			     careercode: 1353,
			     level: 4,
				 phone: Faker::Number.number(digits: 9),
				 department_id: 4)
end


	Tutorial.create(
					title:'Tutoría',
					start:'2019-12-05',
				    end:'2019-12-05',
				    subject:Faker::Number.between(from: 1, to: 3),
				    contents:'Algún contenido',
				    dates:'2019-12-05')
	



5.times do |i|
	StudentTutorial.create(
				   present:[true, false].sample,
				   student_id:i+1,
				   tutorial_id:1 )
end
5.times do |i|
	StudentTutorial.create(
				   present:[true, false].sample,
				   student_id:i+1,
				   tutorial_id:2 )
end
5.times do |i|
	StudentTutorial.create(
				   present:[true, false].sample,
				   student_id:i+1,
				   tutorial_id:3 )
end
5.times do |i|
	StudentTutorial.create(
				   present:[true, false].sample,
				   student_id:i+1,
				   tutorial_id:4 )
end
5.times do |i|
	StudentTutorial.create(
				   present:[true, false].sample,
				   student_id:i+1,
				   tutorial_id:5 )
end
5.times do |i|
	StudentTutorial.create(
				   present:[true, false].sample,
				   student_id:i+1,
				   tutorial_id:6 )
end
5.times do |i|
	StudentTutorial.create(
				   present:[true, false].sample,
				   student_id:i+1,
				   tutorial_id:7 )
end
5.times do |i|
	StudentTutorial.create(
				   present:[true, false].sample,
				   student_id:i+1,
				   tutorial_id:8 )
end
5.times do |i|
	StudentTutorial.create(
				   present:[true, false].sample,
				   student_id:i+1,
				   tutorial_id:9 )
end


4.times do |i|
	TutorTutorial.create(
				   present:[true, false].sample,
				   tutor_id:i+1,
				   tutorial_id:1 )
end
4.times do |i|
	TutorTutorial.create(
				   present:[true, false].sample,
				   tutor_id:i+1,
				   tutorial_id:2 )
end
4.times do |i|
	TutorTutorial.create(
				   present:[true, false].sample,
				   tutor_id:i+1,
				   tutorial_id:3)
end
4.times do |i|
	TutorTutorial.create(
				   present:[true, false].sample,
				   tutor_id:i+1,
				   tutorial_id:4 )
end
4.times do |i|
	TutorTutorial.create(
				   present:[true, false].sample,
				   tutor_id:i+1,
				   tutorial_id:5 )
end
4.times do |i|
	TutorTutorial.create(
				   present:[true, false].sample,
				   tutor_id:i+1,
				   tutorial_id:6 )
end
4.times do |i|
	TutorTutorial.create(
				   present:[true, false].sample,
				   tutor_id:i+1,
				   tutorial_id:7 )
end
4.times do |i|
	TutorTutorial.create(
				   present:[true, false].sample,
				   tutor_id:i+1,
				   tutorial_id:8 )
end
4.times do |i|
	TutorTutorial.create(
				   present:[true, false].sample,
				   tutor_id:i+1,
				   tutorial_id:9 )
end

Subject.create(name:"Cálculo I",level: 1)
Subject.create(name:"Álgebra I",level: 1)
Subject.create(name:"Física I",level: 1)

Activity.destroy_all

AcademicUnit.create(name:"FACULTAD DE INGENIERÍA")#listo1
AcademicUnit.create(name:"FACULTAD DE QUÍMICA Y BIOLOGÍA")#listo2
AcademicUnit.create(name:"FACULTAD DE CIENCIA")#Listo3
AcademicUnit.create(name:"FACULTAD DE CIENCIAS MÉDICAS")#Listo4
AcademicUnit.create(name:"FACULTAD TECNOLÓGICA")#lISTO5
AcademicUnit.create(name:"FACULTAD DE HUMANIDADES")#Listo6
AcademicUnit.create(name:"FACULTAD DE ADMINISTRACIÓN Y ECONOMÍA")#Listo7
AcademicUnit.create(name:"FACULTAD DE DERECHO")#8
AcademicUnit.create(name:"ESCUELA DE ARQUITECTURA")#9
AcademicUnit.create(name:"PROGRAMA DE BACHILLERATO")#10



#Facultad de ingeniería
Department.create(name:"DEPARTAMENTO DE INGENIERÍA ELÉCTRICA", academic_unit_id:1)#1
Department.create(name:"DEPARTAMENTO DE INGENIERÍA GEOGRÁFICA",academic_unit_id:1)#2
Department.create(name:"DEPARTAMENTO DE INGENIERÍA INDUSTRIAL",academic_unit_id:1)#3
Department.create(name:"DEPARTAMENTO DE INGENIERÍA INFORMÁTICA",academic_unit_id:1)#4
Department.create(name:"DEPARTAMENTO DE INGENIERÍA MECÁNICA",academic_unit_id:1)#5
Department.create(name:"DEPARTAMENTO DE INGENIERÍA METALÚRGICA",academic_unit_id:1)#6
Department.create(name:"DEPARTAMENTO DE INGENIERÍA EN MINAS",academic_unit_id:1)#7
Department.create(name:"DEPARTAMENTO DE INGENIERÍA EN OBRAS CIVILES",academic_unit_id:1)#8
Department.create(name:"DEPARTAMENTO DE INGENIERÍA QUÍMICA",academic_unit_id:1)#9


#Facultad de química y biología academic_unit_id: 2
Department.create(name:"DEPARTAMENTOS DE BIOLOGÍA, CIENCIAS DEL AMBIENTE Y QUÍMICA DE LOS MATERIALES", academic_unit_id:2)#10

#Facultad de ciencia academic_unit_id: 3
Department.create(name:"DEPARTAMENTO DE FÍSICA", academic_unit_id:3)#11
Department.create(name:"DEPARTAMENTO DE MATEMÁTICA Y CIENCIA DE LA COMPUTACIÓN", academic_unit_id:3)#12

Department.create(name:"ESCUELA DE MEDICINA", academic_unit_id:4)#13
Department.create(name:"ESCUELA DE ENFERMERÍA", academic_unit_id:4)#14
Department.create(name:"ESCUELA DE OBSTETRICIA Y PUERICULTURA", academic_unit_id:4)#15
Department.create(name:"ESCUELA DE CIENCIAS DE LA ACTIVIDAD FÍSICA, EL DEPORTE Y LA SALUD", academic_unit_id:4)#16
Department.create(name:"TERAPIA OCUPACIONAL", academic_unit_id:4)#17
Department.create(name:"KINESIOLOGÍA", academic_unit_id:4)#18


Department.create(name:"DEPARTAMENTO DE TECNOLOGÍAS INDUSTRIALES", academic_unit_id:5)#19
Department.create(name:"DEPARTAMENTO DE TECNOLOGÍAS DE GESTIÓN", academic_unit_id:5)#20
Department.create(name:"DEPARTAMENTO DE GESTIÓN AGRARIA", academic_unit_id:5)#21
Department.create(name:"DEPARTAMENTO DE CIENC. Y TEC. DE LOS ALIMENTOS", academic_unit_id:5)#22
Department.create(name:"DEPARTAMENTO DE PUBLICIDAD E IMAGEN", academic_unit_id:5)#23


Department.create(name:"DEPARTAMENTO DE EDUCACIÓN", academic_unit_id:6)#24
Department.create(name:"DEPARTAMENTO DE HISTORIA", academic_unit_id:6)#25
Department.create(name:"DEPARTAMENTO DE LINGÜÍSTICA Y LITERATURA", academic_unit_id:6)#26
Department.create(name:"DEPARTAMENTO DE FILOSOFÍA", academic_unit_id:6)#27

Department.create(name:"ESCUELA DE PERIODISMO", academic_unit_id:6)#28
Department.create(name:"ESCUELA DE PSICOLOGÍA", academic_unit_id:6)#29

Department.create(name:"DEPARTAMENTOS FAE", academic_unit_id:7)#30

Department.create(name:"DEPARTAMENTO DE DERECHO", academic_unit_id:8)#31
Department.create(name:"DEPARTAMENTO DE ARQUITECTURA", academic_unit_id:9)#32
Department.create(name:"DEPARTAMENTO BACHILLERATO", academic_unit_id:10)#33


Career.create(code:16100,name:" Derecho",department_id:31)
Career.create(code:16070,name:" Arquitectura",department_id:32)
Career.create(code:16030,name:" Bachillerato en Ciencias y Humanidades",department_id:33)


Career.create(code:16034,name:" Administración Pública",department_id:30)
Career.create(code:16036,name:" Contador Público y Auditor",department_id:30)
Career.create(code:16035,name:" Ingeniería Comercial",department_id:30)




Career.create(code:16056,name:" Pedagogía en Educación General Básica",department_id:24)

Career.create(code:16058,name:" Licenciatura en Historia",department_id:25)
Career.create(code:16057,name:" Licenciatura en Estudios Internacionales",department_id:25)
Career.create(code:16051,name:" Pedagogía en Historia y Ciencias Sociales",department_id:25)

Career.create(code:16052,name:" Pedagogía en Inglés",department_id:26)
Career.create(code:16054,name:" Lic. en Lingüística Aplicada a la Traducción. Especialidad en Inglés, Portugués y Japonés",department_id:26)
Career.create(code:16050,name:" Pedagogía en Castellano",department_id:26)

Career.create(code:16053,name:" Pedagogía en Filosofía",department_id:27)

Career.create(code:16055,name:" Periodismo",department_id:28)

Career.create(code:16060,name:" Psicología",department_id:29)


Career.create(code:16089,name:"	Tecnología en Telecomunicaciones",department_id:19)
Career.create(code:16085,name:"	Tecnología en Automatización Industrial",department_id:19)
Career.create(code:16082,name:"	Tecnología en Construcciones",department_id:19)
Career.create(code:16086,name:"	Tecnología en Mantenimiento Industrial",department_id:19)

Career.create(code:16084,name:" Tecnología en Diseño Industrial",department_id:20)
Career.create(code:16080,name:" Tecnología en Administración de Personal",department_id:20)
Career.create(code:16083,name:" Tecnología en Control Industrial",department_id:20)


Career.create(code:16068,name:" Ingeniero en Agronegocios",department_id:21)

Career.create(code:16081,name:"	Tecnología en Alimentos",department_id:22)
Career.create(code:16067,name:"	Ingeniería de Alimentos",department_id:22)


Career.create(code:16066,name:"	Publicidad",department_id:23)


Career.create(code:16092,name:"	Enfermería",department_id:14)
Career.create(code:16098,name:"	Kinesiología",department_id:18)
Career.create(code:16097,name:"	Lic. en Ciencias de la Actividad Física y Salud / Entrenador Deportivo",department_id:16)
Career.create(code:16096,name:"	Lic. en Ciencias de la Actividad Física y Salud / Terapeuta en Actividad Física y Salud",department_id:16)
Career.create(code:16091,name:"	Medicina",department_id:13)
Career.create(code:16093,name:"	Obstetricia y Puericultura",department_id:15)
Career.create(code:16095,name:"	Pedagogía en Educación Física",department_id:16)
Career.create(code:16099,name:" Terapia Ocupacional",department_id:17)



#Departamento de química y biología department_id: 10
Career.create(code:16041,name:"	Bioquímica y Licenciatura en Bioquímica",department_id:10)
Career.create(code:16043,name:"	Pedagogía en Química y Biología",department_id:10)
Career.create(code:16039,name:"	Química y Farmacia",department_id:10)
Career.create(code:16044,name:"	Química y Licenciatura en Química",department_id:10)


Career.create(code:16049,name:"	Pedagogía en Física y Matemática",department_id:11)
Career.create(code:16042,name:"	Ingeniería Física",department_id:11)

Career.create(code:16048,name:"	Ingeniería Estadística",department_id:12)
Career.create(code:16047,name:"	Ingeniería Matemática",department_id:12)
Career.create(code:16045,name:"	Pedagogía en Matemática y Computación",department_id:12)
Career.create(code:16046,name:"	Lic. en Ciencia de la Computación",department_id:12)


Career.create(code:1353,name:"Ingeniería de Ejecución en Computación e Informática",department_id:4)
Career.create(code:1363,name:"Ingeniería Civil Informática",department_id:4)

Career.create(code:1354,name:"Ingeniería de Ejecución Industrial",department_id:3)
Career.create(code:1364,name:"Ingeniería Civil Industrial",department_id:3)

Career.create(code:1349,name:"Ingeniería de Ejecución en Climatización", department_id:5)


Career.create(code:1351,name:"Ingeniería de Ejecución en Electricidad",department_id:1)
Career.create(code:1361,name:"Ingeniería Civil en Electricidad",department_id:1)

Career.create(code:1357,name:"Ingeniería de Ejecución en Minas",department_id:7)
Career.create(code:1367,name:"Ingeniería Civil en Minas",department_id:7)

Career.create(code:1352,name:"Ingeniería de Ejecución en Geomensura",department_id:2)
Career.create(code:1341,name:"Ingeniería Ambiental",department_id:2)
Career.create(code:1362,name:"Ingeniería Civil en Geografía",department_id:2)

Career.create(code:1356,name:"Ingeniería de Ejecución en Metalurgia",department_id:6)
Career.create(code:1366,name:"Ingeniería Civil en Metalurgia",department_id:6)

Career.create(code:1355,name:"Ingeniería de Ejecución en Mecánica",department_id:5)
Career.create(code:1365,name:"Ingeniería Civil en Mecánica",department_id:5)

Career.create(code:1368,name:"Ingeniería Civil en Obras Civiles",department_id:8)

Career.create(code:1340,name:"Ingeniería en Biotecnología",department_id:9)
Career.create(code:1369,name:"Ingeniería Civil en Química",department_id:9)
Career.create(code:1359,name:"Ingeniería de Ejecución en Química",department_id:9)



Type.create(name: "Trabajo autónomo")
Type.create(name:"Trabajo dirigido")


Typetutorial.create(type_id:1, tutorial_id: 1)
Typetutorial.create(type_id:2, tutorial_id: 2)
Typetutorial.create(type_id:3, tutorial_id: 3)
Typetutorial.create(type_id:3, tutorial_id: 4)
Typetutorial.create(type_id:3, tutorial_id: 5)
Typetutorial.create(type_id:3, tutorial_id: 6)
Typetutorial.create(type_id:3, tutorial_id: 7)
Typetutorial.create(type_id:3, tutorial_id: 8)
Typetutorial.create(type_id:3, tutorial_id: 9)

Role.create(name:'Administrador')
Role.create(name:'Tutor')
Role.create(name:'Coordinador Docente')
Role.create(name:'Supervisor')

user= User.create! :firstname => 'Administrador',
			 :email => 'admin@admin.com',
			  :rolesdevise => 1,
			   :password => '123456',
			    :password_confirmation => '123456',
				 :role_id =>1,
				 	:department_id => 4
user.save!
user2= User.create! :firstname => 'Esteban',
				:lastname => 'Reyes',
			 :email => 'tutor@tutor.com',
			  :rolesdevise => 2,
			   :password => '123456',
			    :password_confirmation => '123456',
				:role_id =>2,
				  :department_id => 4
				
user2.save!
user3= User.create! :firstname => 'Sofía',
				:lastname => 'González',
			 :email => 'coordinador@mail.com',
			  :rolesdevise => 3,
			   :password => '123456',
			    :password_confirmation => '123456',
				 :role_id =>3,
				  :department_id => 4
				 
user3.save!

user4= User.create! :firstname => 'Sofía',
				:lastname => 'González',
			 :email => 'coordinador1@mail.com',
			  :rolesdevise => 1,
			   :password => '123456',
			    :password_confirmation => '123456',
				 :role_id =>1,
				  :department_id => 4
				 
user4.save!


Statusannotation.create(name:'Nuevo')
Statusannotation.create(name:'En revisión')
Statusannotation.create(name:'Cerrado')
Statusannotation.create(name:'Derivado')

Typeannotation.create(name:'Historia')
Typeannotation.create(name:'Alerta')

Studentannotation.create(
						times:'519-08-08',
						comment:'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cumque recusandae voluptatum ex praesentium temporibus, at laboriosam consequatur, deserunt, facere impedit distinctio aut incidunt fugiat accusantium blanditiis, exercitationem doloribus veritatis libero.',
						statusannotation_id:1,
						typeannotation_id:1,
						user_id:1,
						
						student_id:1 )
Studentannotation.create(
						times:'519-08-09',
						comment:'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cumque recusandae voluptatum ex praesentium temporibus, at laboriosam consequatur, deserunt, facere impedit distinctio aut incidunt fugiat accusantium blanditiis, exercitationem doloribus veritatis libero.',
						statusannotation_id:3,
						typeannotation_id:2,
						user_id:1,
						derivation:3,
						student_id:1 )
Studentannotation.create(
						times:'519-08-10',
						comment:'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cumque recusandae voluptatum ex praesentium temporibus, at laboriosam consequatur, deserunt, facere impedit distinctio aut incidunt fugiat accusantium blanditiis, exercitationem doloribus veritatis libero.',
						statusannotation_id:2,
						typeannotation_id:2,
						user_id:1,
						derivation:3,
						student_id:1 )	

