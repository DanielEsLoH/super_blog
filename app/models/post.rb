class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy

    validates :title, presence: true, length: { maximum: 100 }
    validates :content, presence: true, length: { minimum: 250 }

    def truncated_content
        truncate(content, length: 250) # Acortar el contenido a 100 caracteres
    end

    def formatted_content
        Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(truncated_content).html_safe
        # Aplicar el formato Markdown al contenido acortado y convertirlo en HTML seguro para mostrarlo en la vista
    end
end
