FactoryGirl.define do
  factory :post do
    sequence(:title) { |i| "Sample Title #{i}"}
    content 'Lorem ipsum dolor sit amet
    consectetur adipiscing elit. Integer scelerisque risus id nisl ornare, sed volutpat
    felis congue. Praesent sit amet urna justo. Nam eget ultricies orci, quis bibendum
    velit. Nulla vehicula massa placerat ligula congue, non elementum ipsum condimentum.
     Interdum et malesuada fames ac ante ipsum primis in faucibus. Morbi sit amet nunc mauris.
     Maecenas lacus mauris, semper ut diam sed, aliquet malesuada metus. Nulla accumsan lacus
     elit, nec bibendum risus tincidunt sed. Integer eget mauris vitae dolor elementum porttitor
     id in sem. Pellentesque tempor leo et commodo eleifend. Interdum et malesuada fames ac ante
     ipsum primis in faucibus. Pellentesque tempus non tortor ut feugiat. Aenean fringilla sagittis
     lorem quis laoreet. Pellentesque vestibulum gravida dui ac blandit.'

     factory :post_with_attachments do
       after(:create) do |post|
        create_list :attachment, 2, attachable: post
        create_list :picture, 3, imageable: post
       end
     end

  end
end