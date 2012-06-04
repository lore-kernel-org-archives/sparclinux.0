From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 04 Jun 2012 23:28:37 +0000
Subject: Re: sparc32: some more testing
Message-Id: <CAGRGNgXfd2J93EMH9eqcQ_1uax79BKjQwqQhpMbfz7PrE4=WEg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
In-Reply-To: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

I have a SS10 with a hypersparc CPU that I als can't get to boot. It
fails with a level 15 interrupt when it loads the image it received
through TFTP. From what I've read Level 15 = bad ram, but the PROM
ram checks say it's ok. Incidentally, it boots an old (2.4) Gentoo
install image just fine, it's only the 3.x kernel that fails like
this. My next round of tests will be to shrink the kernel image and
probably drop the ROOTFS just to see if I can make it boot.

Once it boots, I'll be able to test any changes you make.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
