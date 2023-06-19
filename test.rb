require 'net/smtp'

message = <<-END.split("\n").map!(&:strip).join("\n")
From: Private Person <from@example.com>
To: A Test User <to@example.com>
Subject: Hello world!

This is a test e-mail message.
END

Net::SMTP.start('sandbox.smtp.mailtrap.io',
              2525,
              'sandbox.smtp.mailtrap.io',
              '8e85afbc75e917', '58ae95b6016c44', :cram_md5) do |smtp|
smtp.send_message message, 'from@example.com',
                          'to@example.com'
end