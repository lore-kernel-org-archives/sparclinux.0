From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 03 Apr 2012 20:44:56 +0000
Subject: sparc32 - keyboard is dead with v3.4-rc1
Message-Id: <20120403204455.GA29433@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all.

I have just tried out v3.4-rc1 on my sparc32 box - and keyboard is not working.
I type my username - but nothing happens.

I see nothing unusual during booting the kernel.
With the same configuration it works with v3.3.

As I have no prime suspects I have started to bisect it -
but wanted to let you know that there is an issue.

bisect will take some time as my build-machine is not exactly
quick - so I expect no result until sometime tomorrow.
But the good thing is that it is easy to test :-)

	Sam
