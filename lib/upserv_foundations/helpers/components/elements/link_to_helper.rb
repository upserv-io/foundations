# frozen_string_literal: true

module Helpers
  module Components
    module Elements
      # various link_to variations
      module LinkToHelper
        # link to an attachment
        # redirect to images and PDFs
        # download all other files
        # this behavior is fairly consistent with what chrome, firefox, safari and edge do
        # except if redirecting in a new tab to a file that should be downloaded,
        # the browsers will open a new tab then close it then download the file which isn't
        # great UI / UX IMO. This method simply automates the process so that no new tab is
        # opened. If this level of automation is not requried, then don't use this method or
        # create some different logic as needed.
        # NOTE: one other nuance is that in addition to images and PDFs, browers will also
        # typically render html / css / js / other web related files inline as well. But,
        # for now, this method is really just meant to differentiate images and PDFs from
        # other types that would be typically downloaded (because rendering an html file as
        # an active storage attachment seems like a really odd thing to do so I'm ignoring
        # that scenario)
        def link_to_attachment(body_or_attachment, attachment_or_html_options = nil,
                               html_options = nil, &block)
          # link to has 2 variations. One where the body is simply a string passed as the
          # first argument. And another, when the body is passed in as a block
          attachment = block ? body_or_attachment : attachment_or_html_options
          # if the attachment is an attachment that can typically be rendered in the browser
          # (ie images and PDFs) rather than forced to be donwloaded (ex. videos), then pass
          # arguments straight to link to
          if attachment.variable? || attachment.content_type == 'application/pdf'
            link_to body_or_attachment, attachment_or_html_options, html_options, &block
          elsif block
            # if the attachment needs to be downloaded and a block was passed, use the block
            # link to arguments
            # NOTE: - no need for html options if we are downloading
            link_to rails_blob_path(attachment, disposition: 'attachment'), &block
          else
            # if the attachment needs to be downloaded and a block was not passed, use the
            # non block link to arguments arguments
            # NOTE: - no need for html options if we are downloading
            link_to body_or_attachment,
                    rails_blob_path(attachment, disposition: 'attachment')
          end
        end

        def link_to_download(body_or_attachment, attachment_or_html_options = nil, &block)
          attachment = block ? body_or_attachment : attachment_or_html_options
          if block
            link_to(rails_blob_path(attachment, disposition: 'attachment'), &block)
          else
            link_to(body_or_attachment,
                    rails_blob_path(attachment, disposition: 'attachment'))
          end
        end
      end
    end
  end
end
