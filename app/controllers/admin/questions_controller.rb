class Admin::QuestionsController < AdminController
  def index
    @bank_questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(question_params)
    if @question.save
      redirect_to admin_questions_path
    else
      flash.now[:error] = "Failed to create question. #{@question.punctuate(@question.errors.to_a)}"
      render :new
    end
  end

  def edit
    @question = current_question
  end

  def update
    @question = current_question
    if @question.update(question_params)
      redirect_to admin_questions_path
    else
      flash.now[:error] = "Failed to update question. #{@question.punctuate(@question.errors.to_a)}"
      render :edit
    end
  end

  def destroy
    @question = current_question
    flash[:error] = "Failed to delete question." if !@question.destroy
    redirect_to admin_questions_path
  end

  private

  def current_question
    @current_question ||= Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :answer)
  end
end
