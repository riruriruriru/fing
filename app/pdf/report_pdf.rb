class ReportPdf < Prawn::Document
	 

	def initialize(students)

		

		super()
		readFiles
		readCareer
		readPeriod
		desertion



		tutorialCharts
		modalidadChart

		 @error=''

		 i=0
		 date=Time.now.strftime("%m-%d-%Y")
  	     year=Time.now.strftime("%Y")
  	     @careers= Career.all
  	     @depart= Department.where(id:@departmentid).pluck(:name).to_sentence
  	     usach = "#{Rails.root}/public/assets/images/usachlogo.png" 
    	 image usach,:at => [20,730], :width => 50
    	 fing = "#{Rails.root}/public/assets/images/logofing2.png" 
    	 image fing,:at => [500,730], :width => 40


    	 if @anio_civil==" "
    	 	@anio_civil= @period

    	 end




  		title= "Reporte"
  		 text " ", :inline_format => true,:leading =>1
  		 
        text "<font size='16'>" +title+"</font>", :inline_format => true, :align=> :center
        text "<font size='14'>" +@depart+"</font>", :inline_format => true, :align=> :center
        text "<font size='12'>(" +date+")</font>", :inline_format => true, :align=> :center, :leading =>40
        text "<font size='14'>" +"<b>Características de ingreso de la cohorte "+@anio_civil.to_s+"</b></font>", :inline_format => true, :align=> :center, :leading =>20

        


        @carreers4department.each_with_index do |id_car,index|
        	@careers.each do |career|
        		if career.id == id_car
		        	text "<font size='14'>"+career.name+"</font>", :inline_format => true, :align=> :left, :leading =>20
		        
		    		carac_table(index+1)
		            text "<font size='12'>" +@error+"</font>", :inline_format => true, :align=> :center

		         	text " ", :inline_format => true,:leading =>20

	        	end
	        end
        end

       
    	
       

		start_new_page

		 text "<font size='14'>" +"<b>Resultados programa de acompañamiento académico</b></font>", :inline_format => true, :align=> :center
		 text "<font size='12'>" +"Periodo "+@period.to_s+"</b></font>", :inline_format => true, :align=> :center, :leading =>20





		 text "<font size='14'>" +"<b>Estadísticas de tutorías</b></font>", :inline_format => true, :align=> :left , :leading =>10

		 text "<font size='12'>" +"<b>Cantidad de tutorías realizadas por asignatura</b></font>", :inline_format => true, :align=> :left, :leading =>10

		 @nameSubjects.each_with_index do |name,i|
		 	
		 	 if @numTutorials[i]>1
		 	 	text "<font size='12'>" +'Se han realizado '+@numTutorials[i].to_s+' tutorías de '+name+"</font>", :inline_format => true, :align=> :left
		 	 else
		 	 	text "<font size='12'>" +'Se ha realizado '+@numTutorials[i].to_s+' tutoría de '+name+"</font>", :inline_format => true, :align=> :left
		 	 end
		 	
		 end
		 text "<font size='14'>" +"", :inline_format => true, :align=> :left, :leading =>20
		 text "<font size='12'>" +"<b>Asistencia a tutorías</b></font>", :inline_format => true, :align=> :left, :leading =>10

		 @nameSubjectsAsis.each_with_index do |nam,i|
		 	 nam.each do |n|
		 	 if @numAsistencia[i]>1
		 	 	text "<font size='12'>" +'En la tutoría de '+n+', realizada el día '+@dateTutorials[i].to_s+' asistieron '+@numAsistencia[i].to_s+' estudiantes.'+"</font>", :inline_format => true, :align=> :left
		 	 else
		 	 	text "<font size='12'>" +'En la tutoría de '+n+', realizada el día '+@dateTutorials[i].to_s+' no asistieron estudiantes.'+"</font>", :inline_format => true, :align=> :left
		 	 end
		 	end
		 end

		 text "<font size='14'>" +"", :inline_format => true, :align=> :left, :leading =>20
		 text "<font size='12'>" +"<b>Modalidad de tutoría</b></font>", :inline_format => true, :align=> :left, :leading =>10

		 ['Trabajo autónomo','Trabajo Dirigido'].each_with_index do |trabajo,i|
		 	
		 	text "<font size='12'>" +'La modalidad "'+trabajo+'", se utilizó en el '+@modalidad[i].to_s+'% de las tutorías. '+"</font>", :inline_format => true, :align=> :left
		 	 
		 	
		 end

		  @notas=[2.2,3.5,3.8]
		  @asistencia=[56,75,63]

		 text "<font size='14'>" +"", :inline_format => true, :align=> :left, :leading =>20
		 


		 


		 


	end


def readCareer
    @careers= Career.all
    @carreers4department=[]
      File.open('careerFile.txt', 'r') do |f1|
        while linea = f1.gets
         @departmentid = linea.chomp
        end
      end
     
    @careers.each do |car|
      if car.department_id ==  @departmentid.to_i
        @carreers4department << car.id
      end
    end


  end


  def csvname(name)
   
	    if name.empty?
	      @CAREER_1 = ""
	      @CAREER_2 = ""
	      @CAREER_3 = ""
	      @CAREER_4 = ""

	    else
	      if !name[0].blank?
	        @CAREER_1 = name[0]
	      else
	         @CAREER_1 = ""
	      end
	      if !name[1].blank?
	        @CAREER_2 = name[1]
	      else
	         @CAREER_2 = ""
	      end
	       if !name[2].blank?
	        @CAREER_3 = name[2]
	       else
	        @CAREER_3 = ""
	        end
	       if !name[3].blank?
	        @CAREER_4 = name[3]
	     else
	       @CAREER_4 = ""
	        end
	      
	    end

  

  end

  def readFiles
	  @name=[]
	      begin
	      	File.open('desertionFiles.txt', 'r') do |f1|
	        while linea = f1.gets
	          @name << linea.chomp
	        end
	        csvname(@name)
	      end
	      rescue
	      	csvname(@name)
	      end
	       
  
  end

def carac_table(n)
	begin
		table carac_career(n) do
			row(0).font_style = :bold
			columns(1..3).align = :center
			self.row_colors = ["DDDDDD","FFFFFF"]
			self.header = true
			self.position = :center
		end
	rescue
		
	end

end



def carac_career(n)


	if n==1
		if @career1.empty?
		@error='No hay datos para mostrar'
		
		else
		@error=''
			[["Característica","Porcentaje de ocurrencia"]]+ 
			@career1.map do |stu|
				if stu['name']=='beca de alimentación JUNAEB'
					[stu['tipo']+" "+stu['name'],stu['valor'].to_s+"%"]
				else
					[stu['name']+stu['tipo'],stu['valor'].to_s+"%"]
				end
			end
		end
	elsif n==2
		if @career2.empty?
		@error='No hay datos para mostrar'
		
		else
		@error=''
			[["Característica","Porcentaje de ocurrencia"]]+ 
			@career2.map do |stu|
				if stu['name']=='beca de alimentación JUNAEB'
					[stu['tipo']+" "+stu['name'],stu['valor'].to_s+"%"]
				else
					[stu['name']+stu['tipo'],stu['valor'].to_s+"%"]
				end
			end
		end
	elsif n==3
		if @career3.empty?
		@error='No hay datos para mostrar'
		else
			@error=''
			[["Característica","Porcentaje de ocurrencia"]]+ 
			@career3.map do |stu|
				if stu['name']=='beca de alimentación JUNAEB'
					[stu['tipo']+" "+stu['name'],stu['valor'].to_s+"%"]
				else
					[stu['name']+stu['tipo'],stu['valor'].to_s+"%"]
				end
			end
		end
	elsif n==4
		if @career4.empty?
		@error='No hay datos para mostrar'
		else
			@error=''
			[["Característica","Porcentaje de ocurrencia"]]+ 
			@career4.map do |stu|
				if stu['name']=='beca de alimentación JUNAEB'
					[stu['tipo']+" "+stu['name'],stu['valor'].to_s+"%"]
				else
					[stu['name']+stu['tipo'],stu['valor'].to_s+"%"]
				end
			end
		end
	end

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
		
		@civil=[]
	rescue Errno::ECONNREFUSED
		flash[:noticen] = "Error de conexión con base de datos externa" 
		@civil=[]
	rescue CSV::MalformedCSVError
		flash[:noticen] = "El archivo "+nomcarrera+" tiene un formato incorrecto" 
		@civil=[]
	rescue RestClient::Exceptions::OpenTimeout
		flash[:noticen] = "Error de conexión con base de datos externa" 
		@civil=[]
	
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

def readPeriod
      begin
        File.open('periodFile.txt', 'r') do |f1|
          while linea = f1.gets
           @per = linea.chomp
          end
        end

        if @per.blank?
          @period = Time.zone.now.year
        else
           @period = @per.to_i
        end
       rescue
         @period = Time.zone.now.year
       end

     
  end


def tutorialCharts
	##Número de tutorías realizadas por cada asignatura
	   tutorials= Tutorial.where('extract(year  from dates) = ?', @period)
	  subjects= Subject.all
	  asistencia= StudentTutorial.all
	  count = subjects.count
	  @numTutorials=[]
	  @nameSubjects=[]
	  @dateTutorials=[]
	  @numAsistencia=[]
	  @nameSubjectsAsis=[]
	  @asistotal=[]

	  @cantTutorials=0

	  for i in 1..count
	  	@numTutorials << 0
	  	@asistotal << 0

	  
	  end
	  subjects.each do |subject|
	   @nameSubjects << subject.name
	  end

	  tutorials.each do |tutorial|
	  @numTutorials[tutorial.subject-1]=@numTutorials[tutorial.subject-1]+1
	  @cantTutorials=@cantTutorials+1
	  @dateTutorials << tutorial.dates
	  end

	  tutorials.each do |t|
	  	sum = StudentTutorial.where(tutorial_id:t.id).where(present: true)
	  	@numAsistencia << sum.count
	  	name = Subject.where(id: t.subject).pluck(:name)
	  	@nameSubjectsAsis << name
	  	
	  end

end

def modalidadChart
  	autonomo = 0
  	dirigido = 0
  	@modalidad = []
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

	 @modalidad << (autonomo*100)/total
	 @modalidad << (dirigido*100)/total


  end

	

end
