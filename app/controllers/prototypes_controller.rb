class PrototypesController < ApplicationController
  # ログインしていないユーザーは以下の操作を不可にする
  before_action :authenticate_user!,
                only: [:new, :create, :edit, :update, :destroy]

  # 共通で対象プロトタイプを取得
  before_action :set_prototype,
                only: [:show, :edit, :update, :destroy]

  # 投稿者本人以外は編集・更新・削除不可
  before_action :move_to_index,
                only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user)
                           .order(created_at: :desc)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment  = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  # 投稿者本人でなければトップへ戻す
  def move_to_index
    redirect_to root_path unless current_user == @prototype.user
  end

  def prototype_params
    params.require(:prototype)
          .permit(:title, :catch_copy, :concept, :image)
          .merge(user_id: current_user.id)
  end
end