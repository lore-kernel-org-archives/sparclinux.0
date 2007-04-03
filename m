From: dpkerr@kerr.net.au
Date: Tue, 03 Apr 2007 11:28:58 +0000
Subject: For Javastation afficionados
Message-Id: <46123a7a.dc.1e3b.17862@kerr.net.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have put together an internet cafe setup for some folks in a third world country to
help them raise cash (from tourists).

I am running 2.4.32 with some processes running on the Krups and others (such as
Firefox and OpenOffice)  X-displaying from a 64bit Suse Server.

The Javastations are proving fantastically reliable compared with PCs which die
quickly in the high heat and humidity.

The JSs are running XFree86 4.2 and the latest fvwm. They NFS mount from the server.

The setup basically works but I would like to improve it if you experts think it
possible. I've read all the threads I can find and tried to implement most ideas bit
not all successfully. Here are my queries:

A. I am running fbdev at 1024x768x8. I have been unsuccessful getting a patched
cyber2000 running. I just get a blank screen when the OS should switch to the driver.
Should I be able to get the cyber2000 patched code running and if I can, will I be
able to get 1024x768x16 or 1280/1024x16 or 1280x1024x8? Or can I do any better that
1024/768x8  from fbdev?

B. I got audio to the point where I could cat *.au files and that worked but I can't
get anything more exotic to work. What is the "best" level of audio support that I
should be able to get out of the JS? I only want to do audio output.

If anyone has any patched drivers, unpublished patches and/or any other wisdom that
would help, I'd be most grateful and it is in a good cause.

Best Regards,

Dave




