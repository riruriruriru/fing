class WelcomeController < ApplicationController
  before_action :authenticate_user!
  before_action :notification
  before_action :readFiles
  before_action :readCareer
  before_action :readPeriod

  def dashboard
    


	  	modalidadChart
	  	tutorialCharts
	  	desertion
	  	
	  	
	  
	  	


		    #Numero de estudiantes
		    students= Student.where(status:true)
		    @students=students.count
		    @careers= Career.all
		    @department= Department.all
	    

  end


  def tutorialCharts
  	##Número de tutorías realizadas por cada asignatura
		  tutorials= Tutorial.where('extract(year  from dates) = ?', @period)
		  
		  @subjects=Subject.all
		  subjects= Subject.all
		  asistencia= StudentTutorial.all
		  if subjects.blank?
		  	 count = 1
		  else
		  	 count = subjects.count
		  end
		 
		  @numTutorials=[]
		  @nameSubjects=[]
		  @dateTutorials=[]
		  @datetutorial=[]
		  @numAsistencia=[]
		  @nameSubjectsAsis=[]
		  @asistotal=[]
		  @tutorialscount=[]
		  @tutocount=[]

		  @cantTutorials=0

		  for i in 1..count
		  	@numTutorials << 0
		  	@asistotal << 0
		  	@tutorialscount << 0
		    @tutocount << 0

		  
		  end
		  subjects.each do |subject|
		   @nameSubjects << subject.name
		  end

		  countt=0

		  if !tutorials.blank? && !@subjects.blank?
		  	tutorials.each do |tutorial|
			  @numTutorials[tutorial.subject-1]=@numTutorials[tutorial.subject-1]+1
			  @cantTutorials=@cantTutorials+1
			  @dateTutorials << tutorial.dates
			  if @datetutorial.empty?
			  		@datetutorial << tutorial.dates.strftime("%d-%m-%Y")
			  elsif @datetutorial[countt]!= tutorial.dates.strftime("%d-%m-%Y")
			  		@datetutorial << tutorial.dates.strftime("%d-%m-%Y")
			  		countt=countt+1
			  end
		  end
		   tutorials.each do |t|
		  	sum = StudentTutorial.where(tutorial_id:t.id).where(present: true)
		  	@numAsistencia << sum.count
		  	name = Subject.where(id: t.subject).pluck(:name)
		  	@nameSubjectsAsis << name
		  	
		  end
		end
		  @datetutorial= @datetutorial.uniq

		  @numasistencias=[]
		  @fechas=[]




		  @datetutorial.each do |fecha|
		  	@fechas<< fecha.to_date
		  end
		 

	@datetutorial.each do |fecha|
			Subject.all.each do |s|
			
				  if Tutorial.where('extract(year  from dates) = ?', @period).where(subject: s.id).where(dates: fecha.to_date).empty?
				  
				  		@numasistencias << 0
				  else
				  	
				  	Tutorial.where('extract(year  from dates) = ?', @period).where(subject: s.id).where(dates: fecha.to_date).first(1).each do |t| #todas las tutorías de x

					  	sum = StudentTutorial.where(tutorial_id:t.id).where(present: true).count
					  	 @numasistencias << sum
					 
					  	
					  	
				 	end

			end

		end
	end

	@tutorialsasis=[]
	

	@datetutorial.each_with_index do |d,index|
		if index==0
		@tutorialsasis<<"params[#{index}]"
		elsif index==1
		@tutorialsasis<<"params[#{index}+asignaturas.length]"
		elsif index>=2
			@tutorialsasis<<"params[#{index}+asignaturas.length*#{index}]"
		end
		
	end




	



	#asistencia.slice(a*3,a*3+3)
		  @asiste=[]
		  @sum
		  

		  @subjects.each_with_index do |asig,i|
		  	Tutorial.where(subject: asig.id).each_with_index do |tuto,p|
		  		@sum = StudentTutorial.where(tutorial_id:tuto.id).where(present: true)
		  	@tutorialscount[i] = @tutorialscount[i]+@sum.count
		  	@tutocount[i] = @tutocount[i]+1
		  	end
		  	
		  end

		  	

		  @notas=[2.2,3.5,3.8]
		  @asistencia=[56,75,63]
  end

  def modalidadChart
	  	autonomo = 0
	  	dirigido = 0
	  	@modalidad = []
	  	#typetutorials= Typetutorial.all

	  	typetutorials= Typetutorial.joins(:tutorial).merge(Tutorial.where('extract(year  from dates) = ?', @period))
		  	typetutorials.each do |type|
		  		if type.type_id == 1
		  			autonomo = autonomo+1
		  		end
		  		if type.type_id == 2
		  			dirigido = dirigido+1
		  		end
		  	end

		total=autonomo+dirigido

		if total==0
		   total=1

		end

		 @modalidad << (autonomo*100)/total
		 @modalidad << (dirigido*100)/total


  end

  def desertion
	  	require 'csv'  
	  	 @numcareers = @carreers4department.count 

	  	
	                                                    

	  	

	  	if @numcareers==1
	  		@careers.each do |c|
		    if c.id == @carreers4department[0]

		    end
	        
	    end
	  	 	if @CAREER_1.empty?
		  		flash[:noticen] = "Faltan archivos de deserción en el directorio. " 
		  	 	
		  	else
		  		@careers.each do |c|
		   			 if c.id == @carreers4department[0]
		   			 	careerdesertion(c.code,@CAREER_1,1)
		   			 end
		   			end
		  		

			end
	  	 end
	  	 if @numcareers==2
	  	 	if @CAREER_1.empty? || @CAREER_2.empty?
		  		flash[:noticen] = "Faltan archivos de deserción en el directorio. " 
		  	 	if !@CAREER_1.empty?
		  	 		@careers.each do |c|
		   			 if c.id == @carreers4department[0]
		   			 	careerdesertion(c.code,@CAREER_1,1)
		   			 end
		   			end
		  	 		else
		  	 		result=[]
		  		   calculo_moda(result,1,1)
		  	 		
		  	 	end
		  	 	if !@CAREER_2.empty? 
		  	 		@careers.each do |c|
		   			 if c.id == @carreers4department[0]
		   			 	careerdesertion(c.code,@CAREER_2,2)
		   			 end
		   			end
		  	 		else
		  	 		result=[]
		  		   calculo_moda(result,2,1)
		  	 		
		  	 	end
		  	else
		  		@careers.each do |c|
		   			 if c.id == @carreers4department[0]
		   			 	careerdesertion(c.code,@CAREER_1,1)
		   			 end
		   			end
		  		@careers.each do |c|
		   			 if c.id == @carreers4department[1]
		   			 	careerdesertion(c.code,@CAREER_2,2)
		   			 end
		   			end

			end
	  	 end
	  	 if @numcareers==3
		  	 if @CAREER_1.empty? || @CAREER_2.empty? || @CAREER_3.empty?
		  	 	flash[:noticen] = "Faltan archivos de deserción en el directorio. " 
		  	 	if !@CAREER_1.empty?
		  	 		@careers.each do |c|
		   			 if c.id == @carreers4department[0]
		   			 	careerdesertion(c.code,@CAREER_1,1)
		   			 end
		   			end
		  	 		else
		  	 		result=[]
		  		   calculo_moda(result,1,1)
		  	 		
		  	 	end
		  	 	if !@CAREER_2.empty? 
		  	 		@careers.each do |c|
		   			 if c.id == @carreers4department[1]
		   			 	careerdesertion(c.code,@CAREER_2,2)
		   			 end
		   			end
		  	 		else
		  	 		result=[]
		  		   calculo_moda(result,2,1)
		  	 		
		  	 	end
		  	 	if !@CAREER_3.empty?
		  	 		@careers.each do |c|
		   			 if c.id == @carreers4department[2]
		   			 	careerdesertion(c.code,@CAREER_3,3)
		   			 end
		   			end
		  	 	else
		  	 		result=[]
		  		   calculo_moda(result,3,1)
		  	 	end
		  		
		  		
		  	else
		  		@careers.each do |c|
		   			 if c.id == @carreers4department[0]
		   			 	careerdesertion(c.code,@CAREER_1,1)
		   			 end
		   			end
		  		@careers.each do |c|
		   			 if c.id == @carreers4department[1]
		   			 	careerdesertion(c.code,@CAREER_2,2)
		   			 end
		   			end
		  		@careers.each do |c|
		   			 if c.id == @carreers4department[2]
		   			 	careerdesertion(c.code,@CAREER_3,3)
		   			 end
		   			end

			end
	  	 end
	  	 if @numcareers==4
	  	 	if @CAREER_1.empty? || @CAREER_2.empty? || @CAREER_3.empty? || @CAREER_4.empty?
		  	flash[:noticen] = "Faltan archivos de deserción en el directorio. " 
		  	 	if !@CAREER_1.empty?
		  	 		@careers.each do |c|
		   			 if c.id == @carreers4department[0]
		   			 	careerdesertion(c.code,@CAREER_1,1)
		   			 end
		   			end
		  	 		else
		  	 		result=[]
		  		   calculo_moda(result,1,1)
		  	 		
		  	 	end
		  	 	if !@CAREER_2.empty? 
		  	 		@careers.each do |c|
		   			 if c.id == @carreers4department[1]
		   			 	careerdesertion(c.code,@CAREER_2,2)
		   			 end
		   			end
		  	 		else
		  	 		result=[]
		  		   calculo_moda(result,2,1)
		  	 		
		  	 	end
		  	 	if !@CAREER_3.empty?
		  	 		@careers.each do |c|
		   			 if c.id == @carreers4department[2]
		   			 	careerdesertion(c.code,@CAREER_3,3)
		   			 end
		   			end
		  	 	else
		  	 		result=[]
		  		   calculo_moda(result,3,1)

		  	 	end
		  	 	if !@CAREER_4.empty?
		  	 		@careers.each do |c|
		   			 if c.id == @carreers4department[3]
		   			 	careerdesertion(c.code,@CAREER_4,4)
		   			 end
		   			end
		  	 	else
		  	 		result=[]
		  		   calculo_moda(result,4,1)
		  		   
		  	 	end
		  	else
		  		@careers.each do |c|
		   			 if c.id == @carreers4department[0]
		   			 	careerdesertion(c.code,@CAREER_1,1)
		   			 end
		   			end
		  		@careers.each do |c|
		   			 if c.id == @carreers4department[0]
		   			 	careerdesertion(c.code,@CAREER_2,2)
		   			 end
		   			end
		   		@careers.each do |c|
		   			 if c.id == @carreers4department[0]
		   			 	careerdesertion(c.code,@CAREER_3,3)
		   			 end
		   			end
		   		@careers.each do |c|
		   			 if c.id == @carreers4department[0]
		   			 	careerdesertion(c.code,@CAREER_4,4)
		   			 end
		   			end


			end
	  	 end
  	 

  end 

def careerdesertion(codcarrera,nomcarrera,n)
	begin

		@rows = []
			CSV.foreach(Rails.root+nomcarrera, headers: true, converters: :all, col_sep: ";") do |row|
			  @rows << row.to_hash
			end
			puts @rows.to_json

			#encontrar a los alumnos con las del 75% de prob. de deserción
			@alumnos =[]
			@rows.each do |r|
				if r['pred_des'].to_f >= 0.75
					@alumnos << r
				end
					
			end



		#Lectura de datos desde API (DATOS /SOCIALDATA)
		@result_civil = []

	    responses = []
	    responses << JSON.parse(RestClient::Request.execute( method: :get, url: "#{ENV['URL_API']}/socialdata/#{@period}"))
	    socialdata = responses[0]
		    socialdata.each do |s|
		    	@alumnos.each do |a|
		    		if a["id"] == s['rut'].to_i
		    			if s['cod_carrera']==codcarrera
		    				@result_civil << s


		    				
		    			end
		    		end
		    	end
		    		
		    end
		total_students=@result_civil.count
		begin
                @anio_civil=@result_civil[0]["anio_ingreso"]
                rescue
		@anio_civil=" "
                end

		response = []
	    response << JSON.parse(RestClient::Request.execute( method: :get, url: "#{ENV['URL_API']}/indices/#{@period}"))
	    indicesdata = response[0]
		    indicesdata.each do |s|
		    	@alumnos.each do |a|
		    		if a["id"] == s['rut'].to_i
		    			if s['cod_carrera']==codcarrera
		    				@result_civil << s




		    				
		    			end
		    		end
		    	end
		    		
		    end

		 #Cálculo de moda de cada ítem
	    
		calculo_moda(@result_civil,n,total_students)
		
	   
	    

	rescue Errno::ENOENT
		flash[:noticen] = "No se encuentra el archivo "+nomcarrera+" en el directorio" 
		
		if n==1
				@career1= []
			elsif n==2
				@career2= []
			elsif n==3
				@career3= []
			elsif n==4
				@career4= []
			end
		
	rescue Errno::ECONNREFUSED
		flash[:noticen] = "Error de conexión con base de datos externa" 
		if n==1
				@career1= []
			elsif n==2
				@career2= []
			elsif n==3
				@career3= []
			elsif n==4
				@career4= []
			end
		
	rescue CSV::MalformedCSVError
		flash[:noticen] = "El archivo "+nomcarrera+" tiene un formato incorrecto" 
		if n==1
				@career1= []
			elsif n==2
				@career2= []
			elsif n==3
				@career3= []
			elsif n==4
				@career4= []
			end
		
	rescue RestClient::Exceptions::OpenTimeout
		flash[:noticen] = "Error de conexión con base de datos externa" 
		if n==1
				@career1= []
			elsif n==2
				@career2= []
			elsif n==3
				@career3= []
			elsif n==4
				@career4= []
			end
		
	
	end

end 


def calculo_moda(result,n,total)
	 quintiles=[0,0,0,0,0]
	 educ_madre=[0,0,0,0,0]
	 educ_padre=[0,0,0,0,0]
	 jefe_f=[0,0,0,0,0,0,0,0,0]
	 cantidad_integ=[0,0,0,0,0,0,0,0,0,0] #tope de 10?
	 becajunaeb=[0,0]
	 ppa=[0,0,0,0,0,0,0]
	 nas=[0,0,0,0,0,0,0]
	 nar=[0,0,0,0,0,0,0]
	 fa=[0,0,0,0,0,0,0,0,0,0]
	 fe=[0,0,0,0,0,0,0,0,0,0]
	

	 nombre_jefefamilia=["Padre del postulante", "Cónyuge del postulante","El postulante",
	 					"Madre del postulante","Abuelo(a)","Otra persona","Otro familiar del postulante",
	 					"Hermano(a)","S/I"]
	 nombre_educacion=["Básica incompleta","Básica completa","Media incompleta","Media completa","Técnico nivel superior incompleta",
	 					"Técnico nivel superior completa","Profesional o universitaria incompleta","Profesional o universitaria completa"]

	 junaeb=["No posee","Posee"]

	 if result.empty?
	 	if n==1
				@career1= []
			elsif n==2
				@career2= []
			elsif n==3
				@career3= []
			elsif n==4
				@career4= []
			end
		

	 else
	 	result.each do |r|
	 		#Quintil
		 		if r["quintil"]==1
		 			quintiles[0]=quintiles[0]+1
		 		elsif r["quintil"]==2
		 			quintiles[1]=quintiles[1]+1
		 		elsif r["quintil"]==3
		 			quintiles[2]=quintiles[2]+1
		 		elsif r["quintil"]==4
		 			quintiles[3]=quintiles[3]+1
		 		elsif r["quintil"]==5
		 			quintiles[4]=quintiles[4]+1

		 		end

		 	#PPA

		 		if    0 < (r["ppa_s1"].to_f) && (r["ppa_s1"].to_f) <=1
		 			ppa[0]=ppa[0]+1
		 		elsif  1 < (r["ppa_s1"].to_f) && (r["ppa_s1"].to_f) <=2
		 			ppa[1]=ppa[1]+1
		 		elsif  2 < (r["ppa_s1"].to_f) && (r["ppa_s1"].to_f) <=3
		 			ppa[2]=ppa[2]+1
		 		elsif  3 < (r["ppa_s1"].to_f) && (r["ppa_s1"].to_f) <=4
		 			ppa[3]=ppa[3]+1
		 		elsif  4 < (r["ppa_s1"].to_f) && (r["ppa_s1"].to_f) <=5
		 			ppa[4]=ppa[4]+1
		 		elsif  5 < (r["ppa_s1"].to_f) && (r["ppa_s1"].to_f) <=6
		 			ppa[5]=ppa[5]+1
		 		elsif  6 < (r["ppa_s1"].to_f) && (r["ppa_s1"].to_f) <=7
		 			ppa[6]=ppa[6]+1

		 		end

		 	#FA (factor de avance)

		 		if    0 < (r["fa_s1"].to_f) && (r["fa_s1"].to_f) <=10
		 			fa[0]=fa[0]+1
		 		elsif  10 < (r["fa_s1"].to_f) && (r["fa_s1"].to_f) <=20
		 			fa[1]=fa[1]+1
		 		elsif  20 < (r["fa_s1"].to_f) && (r["fa_s1"].to_f) <=30
		 			fa[2]=fa[2]+1
		 		elsif  30 < (r["fa_s1"].to_f) && (r["fa_s1"].to_f) <=40
		 			fa[3]=fa[3]+1
		 		elsif  40 < (r["fa_s1"].to_f) && (r["fa_s1"].to_f) <=50
		 			fa[4]=fa[4]+1
		 		elsif  50 < (r["fa_s1"].to_f) && (r["fa_s1"].to_f) <=60
		 			fa[5]=fa[5]+1
		 		elsif  60 < (r["fa_s1"].to_f) && (r["fa_s1"].to_f) <=70
		 			fa[6]=fa[6]+1
		 		elsif  70 < (r["fa_s1"].to_f) && (r["fa_s1"].to_f) <=80
		 			fa[7]=fa[7]+1
		 		elsif  80 < (r["fa_s1"].to_f) && (r["fa_s1"].to_f) <=90
		 			fa[8]=fa[8]+1
		 		elsif  90 < (r["fa_s1"].to_f) && (r["fa_s1"].to_f) <=100
		 			fa[9]=fa[9]+1

		 		end

		 	#FE (factor de eficiencia)

		 		if    0 < (r["fe_s1"].to_f) && (r["fe_s1"].to_f) <=10
		 			fe[0]=fe[0]+1
		 		elsif  10 < (r["fe_s1"].to_f) && (r["fe_s1"].to_f) <=20
		 			fe[1]=fe[1]+1
		 		elsif  20 < (r["fe_s1"].to_f) && (r["fe_s1"].to_f) <=30
		 			fe[2]=fe[2]+1
		 		elsif  30 < (r["fe_s1"].to_f) && (r["fe_s1"].to_f) <=40
		 			fe[3]=fe[3]+1
		 		elsif  40 < (r["fe_s1"].to_f) && (r["fe_s1"].to_f) <=50
		 			fe[4]=fe[4]+1
		 		elsif  50 < (r["fe_s1"].to_f) && (r["fe_s1"].to_f) <=60
		 			fe[5]=fe[5]+1
		 		elsif  60 < (r["fe_s1"].to_f) && (r["fe_s1"].to_f) <=70
		 			fe[6]=fe[6]+1
		 		elsif  70 < (r["fe_s1"].to_f) && (r["fe_s1"].to_f) <=80
		 			fe[7]=fe[7]+1
		 		elsif  80 < (r["fe_s1"].to_f) && (r["fe_s1"].to_f) <=90
		 			fe[8]=fe[8]+1
		 		elsif  90 < (r["fe_s1"].to_f) && (r["fe_s1"].to_f) <=100
		 			fe[9]=fe[9]+1

		 		end

		 	#NAR aprobadas / reprobadas

		 		if    0 < (r["nar_s1"].to_f) && (r["nar_s1"].to_f) <=1
		 			nar[0]=nar[0]+1
		 		elsif  1 < (r["nar_s1"].to_f) && (r["nar_s1"].to_f) <=2
		 			nar[1]=nar[1]+1
		 		elsif  2 < (r["nar_s1"].to_f) && (r["nar_s1"].to_f) <=3
		 			nar[2]=nar[2]+1
		 		elsif  3 < (r["nar_s1"].to_f) && (r["nar_s1"].to_f) <=4
		 			nar[3]=nar[3]+1
		 		elsif  4 < (r["nar_s1"].to_f) && (r["nar_s1"].to_f) <=5
		 			nar[4]=nar[4]+1
		 		elsif  5 < (r["nar_s1"].to_f) && (r["nar_s1"].to_f) <=6
		 			nar[5]=nar[5]+1
		 		elsif  6 < (r["nar_s1"].to_f) && (r["nar_s1"].to_f) <=7
		 			nar[6]=nar[6]+1
		 		
		 		end
		 	#NAS aprobadas / SEMESTRES

		 		if    0 < (r["nas_s1"].to_f) && (r["nas_s1"].to_f) <=1
		 			nas[0]=nas[0]+1
		 		elsif  1 < (r["nas_s1"].to_f) && (r["nas_s1"].to_f) <=2
		 			nas[1]=nas[1]+1
		 		elsif  2 < (r["nas_s1"].to_f) && (r["nas_s1"].to_f) <=3
		 			nas[2]=nas[2]+1
		 		elsif  3 < (r["nas_s1"].to_f) && (r["nas_s1"].to_f) <=4
		 			nas[3]=nas[3]+1
		 		elsif  4 < (r["nas_s1"].to_f) && (r["nas_s1"].to_f) <=5
		 			nas[4]=nas[4]+1
		 		elsif  5 < (r["nas_s1"].to_f) && (r["nas_s1"].to_f) <=6
		 			nas[5]=nas[5]+1
		 		elsif  6 < (r["nas_s1"].to_f) && (r["nas_s1"].to_f) <=7
		 			nas[6]=nas[6]+1
		 		
		 		end


		 		

		 	#Educacion madre
		 	if r["educacion_madre"]==1
		 			educ_madre[0]=educ_madre[0]+1
		 		elsif r["educacion_madre"]==2
		 			educ_madre[1]=educ_madre[1]+1
		 		elsif r["educacion_madre"]==3
		 			educ_madre[2]=educ_madre[2]+1
		 		elsif r["educacion_madre"]==4
		 			educ_madre[3]=educ_madre[3]+1
		 		elsif r["educacion_madre"]==5
		 			educ_madre[4]=educ_madre[4]+1

		 		end

		 	#Educacion padre
		 	if r["educacion_padre"]==1
		 			educ_padre[0]=educ_padre[0]+1
		 		elsif r["educacion_padre"]==2
		 			educ_padre[1]=educ_padre[1]+1
		 		elsif r["educacion_padre"]==3
		 			educ_padre[2]=educ_padre[2]+1
		 		elsif r["educacion_padre"]==4
		 			educ_padre[3]=educ_padre[3]+1
		 		elsif r["educacion_padre"]==5
		 			educ_padre[4]=educ_padre[4]+1

		 		end

		 	#Jefe de familia
		 		if r["jefe_familia"]=="PADRE DEL POSTULANTE"
		 			jefe_f[0]=jefe_f[0]+1
		 		elsif r["jefe_familia"]=="CONYUGE DEL POSTULANTE"
		 			jefe_f[1]=jefe_f[1]+1
		 		elsif r["jefe_familia"]=="EL POSTULANTE"
		 			jefe_f[2]=jefe_f[2]+1
		 		elsif r["jefe_familia"]=="MADRE DEL POSTULANTE"
		 			jefe_f[3]=jefe_f[3]+1
		 		elsif r["jefe_familia"]=="ABUELO(A)"
		 			jefe_f[4]=jefe_f[4]+1
		 		elsif r["jefe_familia"]=="OTRA PERSONA"
		 			jefe_f[5]=jefe_f[5]+1
		 		elsif r["jefe_familia"]=="OTRO FAMILIAR DEL POSTULANTE"
		 			jefe_f[6]=jefe_f[6]+1
		 		elsif r["jefe_familia"]=="HERMANO(A)"
		 			jefe_f[7]=jefe_f[7]+1
		 		elsif r["jefe_familia"]=="S/I"
		 			jefe_f[8]=jefe_f[8]+1
		 		end

		 	#cantidad de integrantes
		 		if r["cantidad_integrantes_grupo_familiar"]==1
		 			cantidad_integ[0]=cantidad_integ[0]+1
		 		elsif r["cantidad_integrantes_grupo_familiar"]==2
		 			cantidad_integ[1]=cantidad_integ[1]+1
		 		elsif r["cantidad_integrantes_grupo_familiar"]==3
		 			cantidad_integ[2]=cantidad_integ[2]+1
		 		elsif r["cantidad_integrantes_grupo_familiar"]==4
		 			cantidad_integ[3]=cantidad_integ[3]+1
		 		elsif r["cantidad_integrantes_grupo_familiar"]==5
		 			cantidad_integ[4]=cantidad_integ[4]+1
		 		elsif r["cantidad_integrantes_grupo_familiar"]==6
		 			cantidad_integ[5]=cantidad_integ[5]+1
		 		elsif r["cantidad_integrantes_grupo_familiar"]==7
		 			cantidad_integ[6]=cantidad_integ[6]+1
		 		elsif r["cantidad_integrantes_grupo_familiar"]==8
		 			cantidad_integ[7]=cantidad_integ[7]+1
		 		elsif r["cantidad_integrantes_grupo_familiar"]==9
		 			cantidad_integ[8]=cantidad_integ[8]+1
		 		elsif r["cantidad_integrantes_grupo_familiar"]==10
		 			cantidad_integ[9]=cantidad_integ[9]+1
		 		end

		 		#IDH COMUNAL
		 		#SE CALCULA DE AHI MISMO

		 		#Beca junaeb
		 		if r["beca_de_alimentacion_junaeb"]==0
		 			becajunaeb[0]=becajunaeb[0]+1
		 		elsif r["beca_de_alimentacion_junaeb"]==1
		 			becajunaeb[1]=becajunaeb[1]+1

		 		end



	 end
	 #BÚSQUEDA DE MODA

	 #Moda quintiles -----------------------------------------------------------------------

	    @quintiles_mayor=0
	 	@quintiles_posicion=[]

				    quintiles.each_with_index do |r, i| #calculo del mayor
				 		if r >= @quintiles_mayor
			      			@quintiles_mayor= r
			      		end

				 	end

				 	quintiles.each_with_index do |r,i| #ubicacion de la o las modas
				 		if r==@quintiles_mayor && @quintiles_mayor != 1 #no hay moda cuando el valor es 1
				 			@quintiles_posicion[i]=1
				 		else
				 			@quintiles_posicion[i]=0
				 		end
				 	end
	    #Moda PPA -----------------------------------------------------------------------

	    @ppa_mayor=0
	 	@ppa_posicion=[]

				    ppa.each_with_index do |r, i| #calculo del mayor
				 		if r >= @ppa_mayor
			      			@ppa_mayor= r
			      		end

				 	end

				 	ppa.each_with_index do |r,i| #ubicacion de la o las modas
				 		if r==@ppa_mayor && @ppa_mayor != 1 #no hay moda cuando el valor es 1
				 			@ppa_posicion[i]=1
				 		else
				 			@ppa_posicion[i]=0
				 		end
				 	end

		#Moda FA -----------------------------------------------------------------------

	    @fa_mayor=0
	 	@fa_posicion=[]

				    fa.each_with_index do |r, i| #calculo del mayor
				 		if r >= @fa_mayor
			      			@fa_mayor= r
			      		end

				 	end

				 	fa.each_with_index do |r,i| #ubicacion de la o las modas
				 		if r==@fa_mayor && @fa_mayor != 1 #no hay moda cuando el valor es 1
				 			@fa_posicion[i]=1
				 		else
				 			@fa_posicion[i]=0
				 		end
				 	end
		#Moda FE -----------------------------------------------------------------------

	    @fe_mayor=0
	 	@fe_posicion=[]

				    fe.each_with_index do |r, i| #calculo del mayor
				 		if r >= @fe_mayor
			      			@fe_mayor= r
			      		end

				 	end

				 	fe.each_with_index do |r,i| #ubicacion de la o las modas
				 		if r==@fe_mayor && @fe_mayor != 1 #no hay moda cuando el valor es 1
				 			@fe_posicion[i]=1
				 		else
				 			@fe_posicion[i]=0
				 		end
				 	end

		#Moda NAR -----------------------------------------------------------------------

	    @nar_mayor=0
	 	@nar_posicion=[]

				    nar.each_with_index do |r, i| #calculo del mayor
				 		if r >= @nar_mayor
			      			@nar_mayor= r
			      		end

				 	end

				 	nar.each_with_index do |r,i| #ubicacion de la o las modas
				 		if r==@nar_mayor && @nar_mayor != 1 #no hay moda cuando el valor es 1
				 			@nar_posicion[i]=1
				 		else
				 			@nar_posicion[i]=0
				 		end
				 	end

		#Moda NAS -----------------------------------------------------------------------

	    @nas_mayor=0
	 	@nas_posicion=[]

				    nas.each_with_index do |r, i| #calculo del mayor
				 		if r >= @nas_mayor
			      			@nas_mayor= r
			      		end

				 	end

				 	nas.each_with_index do |r,i| #ubicacion de la o las modas
				 		if r==@nas_mayor && @nas_mayor != 1 #no hay moda cuando el valor es 1
				 			@nas_posicion[i]=1
				 		else
				 			@nas_posicion[i]=0
				 		end
				 	end





	    #Moda educación madre  -----------------------------------------------------------------------

	    @edmadre_mayor=0
	 	@edmadre_posicion=[]

				    educ_madre.each_with_index do |r, i| #calculo del mayor
				 		if r >= @edmadre_mayor
			      			@edmadre_mayor= r
			      		end

				 	end

				 	educ_madre.each_with_index do |r,i| #ubicacion de la o las modas
				 		if r==@edmadre_mayor && @edmadre_mayor != 1 #no hay moda cuando el valor es 1
				 			@edmadre_posicion[i]=1
				 		else
				 			@edmadre_posicion[i]=0
				 		end
				 	end

	 	#Moda educación padre  -----------------------------------------------------------------------

	    @edpadre_mayor=0
	 	@edpadre_posicion=[]

				    educ_padre.each_with_index do |r, i| #calculo del mayor
				 		if r >= @edpadre_mayor
			      			@edpadre_mayor= r
			      		end

				 	end

				 	educ_padre.each_with_index do |r,i| #ubicacion de la o las modas
				 		if r==@edpadre_mayor && @edpadre_mayor != 1 #no hay moda cuando el valor es 1
				 			@edpadre_posicion[i]=1
				 		else
				 			@edpadre_posicion[i]=0
				 		end
				 	end

		#Moda jefe_familia  -----------------------------------------------------------------------

	    @jfamilia_mayor=0
	 	@jfamilia_posicion=[]

				    jefe_f.each_with_index do |r, i| #calculo del mayor
				 		if r >= @jfamilia_mayor
			      			@jfamilia_mayor= r
			      		end

				 	end

				 	jefe_f.each_with_index do |r,i| #ubicacion de la o las modas
				 		if r==@jfamilia_mayor && @jfamilia_mayor != 1 #no hay moda cuando el valor es 1
				 			@jfamilia_posicion[i]=1
				 		else
				 			@jfamilia_posicion[i]=0
				 		end
				 	end

		#Moda cantidad_integ  -----------------------------------------------------------------------

	    @cinteg_mayor=0
	 	@cinteg_posicion=[]

				    cantidad_integ.each_with_index do |r, i| #calculo del mayor
				 		if r >= @cinteg_mayor
			      			@cinteg_mayor= r
			      		end

				 	end

				 	cantidad_integ.each_with_index do |r,i| #ubicacion de la o las modas
				 		if r==@cinteg_mayor && @cinteg_mayor != 1 #no hay moda cuando el valor es 1
				 			@cinteg_posicion[i]=1
				 		else
				 			@cinteg_posicion[i]=0
				 		end
				 	end

		#Moda beca_juna  -----------------------------------------------------------------------

	    @bjuna_mayor=0
	 	@bjuna_posicion=[]

				    becajunaeb.each_with_index do |r, i| #calculo del mayor
				 		if r >= @bjuna_mayor
			      			@bjuna_mayor= r
			      		end

				 	end

				 	becajunaeb.each_with_index do |r,i| #ubicacion de la o las modas
				 		if r == @bjuna_mayor #no hay moda cuando el valor es 1
				 			@bjuna_posicion[i]=1
				 		else
				 			@bjuna_posicion[i]=0
				 		end
				 	end

		# BUSQUEDA DE CARACTERISTICAS MÁS REPETIDAS



		
		carac_career1=[]
		carac_career2=[]
		carac_career3=[]
		carac_career4=[]

		#@numcareers
		begin

			if @edpadre_mayor > 1
				@edpadre_posicion.each_with_index do |r, i| #calculo del mayor
				 		if r == 1
				 			if n==1
				 			carac_career1 << {"name"=>'Educación del padre: ',"tipo"=> nombre_educacion[i+1],"valor"=>(@edpadre_mayor*100)/total}
				 			
				 			elsif n==2
				 			carac_career2 << {"name"=>'Educación del padre: ',"tipo"=>nombre_educacion[i+1],"valor"=>(@edpadre_mayor*100)/total}
			      			elsif n==3
				 			carac_career3 << {"name"=>'Educación del padre: ',"tipo"=>nombre_educacion[i+1],"valor"=>(@edpadre_mayor*100)/total}
				 		     elsif n==4
				 			carac_career4 << {"name"=>'Educación del padre: ',"tipo"=>nombre_educacion[i+1],"valor"=>(@edpadre_mayor*100)/total}
				 				
				 			end
			      			
			      		end

				 	end

			end

			if @ppa_mayor > 1
				@ppa_posicion.each_with_index do |r, i| #calculo del mayor
				 		if r == 1
				 			if n==1
				 			carac_career1 << {"name"=>'PPA menor o igual a ',"tipo"=>(i+1).to_s+',0',"valor"=>(@ppa_mayor*100)/total}
				 			
				 			elsif n==2
				 			carac_career2 << {"name"=>'PPA menor o igual a: ',"tipo"=>(i+1).to_s+',0',"valor"=>(@ppa_mayor*100)/total}
				 			elsif n==3
				 			carac_career3 << {"name"=>'PPA menor o igual a: ',"tipo"=>(i+1).to_s+',0',"valor"=>(@ppa_mayor*100)/total}
				 			elsif n==4
				 			carac_career4 << {"name"=>'PPA menor o igual a: ',"tipo"=>(i+1).to_s+',0',"valor"=>(@ppa_mayor*100)/total}
			      			
				 				
				 			end
			      			
			      		end

				 	end

			end
			if @nar_mayor > 1
				@nar_posicion.each_with_index do |r, i| #calculo del mayor
				 		if r == 1
				 			if n==1
				 			carac_career1 << {"name"=>'NAR menor o igual a ',"tipo"=>(i+1).to_s+',0',"valor"=>(@nar_mayor*100)/total}
				 			
				 			elsif n==2
				 			carac_career2 << {"name"=>'NAR menor o igual a: ',"tipo"=>(i+1).to_s+',0',"valor"=>(@nar_mayor*100)/total}
				 			elsif n==3
				 			carac_career3 << {"name"=>'NAR menor o igual a: ',"tipo"=>(i+1).to_s+',0',"valor"=>(@nar_mayor*100)/total}
				 			elsif n==4
				 			carac_career4 << {"name"=>'NAR menor o igual a: ',"tipo"=>(i+1).to_s+',0',"valor"=>(@nar_mayor*100)/total}
			      			
				 				
				 			end
			      			
			      		end

				 	end

			end

			if @nas_mayor > 1
				@nas_posicion.each_with_index do |r, i| #calculo del mayor
				 		if r == 1
				 			if n==1
				 			carac_career1 << {"name"=>'NAS menor o igual a ',"tipo"=>(i+1).to_s+',0',"valor"=>(@nas_mayor*100)/total}
				 			
				 			elsif n==2
				 			carac_career2 << {"name"=>'NAS menor o igual a: ',"tipo"=>(i+1).to_s+',0',"valor"=>(@nas_mayor*100)/total}
				 			elsif n==3
				 			carac_career3 << {"name"=>'NAS menor o igual a: ',"tipo"=>(i+1).to_s+',0',"valor"=>(@nas_mayor*100)/total}
				 			elsif n==4
				 			carac_career4<< {"name"=>'NAS menor o igual a: ',"tipo"=>(i+1).to_s+',0',"valor"=>(@nas_mayor*100)/total}
			      			
				 				
				 			end
			      			
			      		end

				 	end

			end


			if @fa_mayor > 1
				@fa_posicion.each_with_index do |r, i| #calculo del mayor
				 		if r == 1
				 			if n==1
				 			carac_career1 << {"name"=>'Avance menor o igual a ',"tipo"=>(i+10).to_s+'%',"valor"=>(@fa_mayor*100)/total}
				 			
				 			elsif n==2
				 			carac_career2 << {"name"=>'Avance menor o igual a: ',"tipo"=>(i+10).to_s+'%',"valor"=>(@fa_mayor*100)/total}
				 		    elsif n==3
				 			carac_career3 << {"name"=>'Avance menor o igual a: ',"tipo"=>(i+10).to_s+'%',"valor"=>(@fa_mayor*100)/total}
				 	     	elsif n==4
				 			carac_career4 << {"name"=>'Avance menor o igual a: ',"tipo"=>(i+10).to_s+'%',"valor"=>(@fa_mayor*100)/total}
			      			
				 				
				 			end
			      			
			      		end

				 	end

			end

			if @fe_mayor > 1
				@fe_posicion.each_with_index do |r, i| #calculo del mayor
				 		if r == 1
				 			if n==1
				 			carac_career1 << {"name"=>'Eficiencia menor o igual a ',"tipo"=>(i+10).to_s+'%',"valor"=>(@fe_mayor*100)/total}
				 			
				 			elsif n==2
				 			carac_career2 << {"name"=>'Eficiencia menor o igual a: ',"tipo"=>(i+10).to_s+'%',"valor"=>(@fe_mayor*100)/total}
				 			elsif n==3
				 			carac_career3 << {"name"=>'Eficiencia menor o igual a: ',"tipo"=>(i+10).to_s+'%',"valor"=>(@fe_mayor*100)/total}
				 			elsif n==4
				 			carac_career4 << {"name"=>'Eficiencia menor o igual a: ',"tipo"=>(i+10).to_s+'%',"valor"=>(@fe_mayor*100)/total}
			      			
				 				
				 			end
			      			
			      		end

				 	end

			end


			if @bjuna_mayor > 1
				@bjuna_posicion.each_with_index do |r, i| #calculo del mayor
				 		if r == 1
				 			if n==1
				 			carac_career1 <<  {"name"=>'beca de alimentación JUNAEB',"tipo"=>junaeb[i],"valor"=>(@bjuna_mayor*100)/total}
			      			
				 			elsif n==2
				 			carac_career2 << {"name"=>'beca de alimentación JUNAEB',"tipo"=>junaeb[i],"valor"=>(@bjuna_mayor*100)/total}
				 			elsif n==3
				 			carac_career3 << {"name"=>'beca de alimentación JUNAEB',"tipo"=>junaeb[i],"valor"=>(@bjuna_mayor*100)/total}
				 			elsif n==4
				 			carac_career4 << {"name"=>'beca de alimentación JUNAEB',"tipo"=>junaeb[i],"valor"=>(@bjuna_mayor*100)/total}
				 				
				 			end
			      		
			      		end

				 	end
			end
			if @quintiles_mayor > 1
				@quintiles_posicion.each_with_index do |r, i| #calculo del mayor
				 		if r == 1
				 			if n==1
				 			carac_career1 << {"name"=>'Pertenece a quintil ',"tipo"=>(i+1).to_s,"valor"=>(@quintiles_mayor*100)/total}
				 			elsif n==2
				 			carac_career2 << {"name"=>'Pertenece a quintil ',"tipo"=>(i+1).to_s,"valor"=>(@quintiles_mayor*100)/total}
				 			elsif n==3
				 			carac_career3 << {"name"=>'Pertenece a quintil ',"tipo"=>(i+1).to_s,"valor"=>(@quintiles_mayor*100)/total}
				 			elsif n==4
				 			carac_career4 << {"name"=>'Pertenece a quintil ',"tipo"=>(i+1).to_s,"valor"=>(@quintiles_mayor*100)/total}
				 				
				 			end
			      			
			      		end

				 	end
			end
			if @edmadre_mayor > 1
				@edmadre_posicion.each_with_index do |r, i| #calculo del mayor
				 		if r == 1
			      			if n==1
				 			carac_career1 << {"name"=>'Educación de la madre: ',"tipo"=>nombre_educacion[i+1],"valor"=>(@edmadre_mayor*100)/total}
				 			elsif n==2
				 			carac_career2 << {"name"=>'Educación de la madre: ',"tipo"=>nombre_educacion[i+1],"valor"=>(@edmadre_mayor*100)/total}
				 			elsif n==3
				 			carac_career3 << {"name"=>'Educación de la madre: ',"tipo"=>nombre_educacion[i+1],"valor"=>(@edmadre_mayor*100)/total}
				 			elsif n==4
				 			carac_career4 << {"name"=>'Educación de la madre: ',"tipo"=>nombre_educacion[i+1],"valor"=>(@edmadre_mayor*100)/total}
				 				
				 			end
			      		end

				 	end
			end
			if @jfamilia_mayor > 1
				@jfamilia_posicion.each_with_index do |r, i| #calculo del mayor
				 		if r == 1
			      			if n==1
				 			carac_career1 << {"name"=>'Jefe de familia: ',"tipo"=>nombre_jefefamilia[i+1],"valor"=>(@jfamilia_mayor*100)/total}
				 			elsif n==2
				 			carac_career2 << {"name"=>'Jefe de familia: ',"tipo"=>nombre_jefefamilia[i+1],"valor"=>(@jfamilia_mayor*100)/total}
				 			elsif n==3
				 			carac_career3 << {"name"=>'Jefe de familia: ',"tipo"=>nombre_jefefamilia[i+1],"valor"=>(@jfamilia_mayor*100)/total}
				 			elsif n==4
				 			carac_career4 << {"name"=>'Jefe de familia: ',"tipo"=>nombre_jefefamilia[i+1],"valor"=>(@jfamilia_mayor*100)/total}
				 				
				 			end
			      		end

				 	end
			end
			if @cinteg_mayor > 1	
				@cinteg_posicion.each_with_index do |r, i| #calculo del mayor
				 		if r == 1
			      			if n==1
				 			carac_career1 << {"name"=>'Integrantes del grupo familiar: ',"tipo"=>(i+1).to_s,"valor"=>(@cinteg_mayor*100)/total}
				 			elsif n==2
				 			carac_career2 << {"name"=>'Integrantes del grupo familiar: ',"tipo"=>(i+1).to_s,"valor"=>(@cinteg_mayor*100)/total}
				 			elsif n==3
				 			carac_career3 << {"name"=>'Integrantes del grupo familiar: ',"tipo"=>(i+1).to_s,"valor"=>(@cinteg_mayor*100)/total}
				 			elsif n==4
				 			carac_career4 << {"name"=>'Integrantes del grupo familiar: ',"tipo"=>(i+1).to_s,"valor"=>(@cinteg_mayor*100)/total}
				 				
				 			end
			      		end

				 	end
			end

			if n==1
				@career1= carac_career1.sort_by{|x| -x['valor']}
			elsif n==2
				@career2= carac_career2.sort_by{|x| -x['valor']}
			elsif n==3
				@career3= carac_career3.sort_by{|x| -x['valor']}
			elsif n==4
				@career4= carac_career4.sort_by{|x| -x['valor']}
			end


		rescue ZeroDivisionError
		if n==1
				@career1= []
			elsif n==2
				@career2= []
			elsif n==3
				@career3= []
			elsif n==4
				@career4= []
			end
		end
	 end

		
end

	


	


  def report
  	@students= Student.order("id DESC").all
  	datenow = Time.now.strftime("%d-%m-%Y_%H-%M")
  	respond_to do |format|
      format.html
      format.pdf do 
        pdf = ReportPdf.new(@students)
        send_data pdf.render, filename: 'reporte_'+datenow+'.pdf',type:'application/pdf', disposition: "inline"
      end
        
      end
  	
  end
  

  

end
