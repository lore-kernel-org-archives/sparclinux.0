From: Pedro Ramalhais <ramalhais@serrado.net>
Date: Mon, 14 Feb 2005 18:08:12 +0000
Subject: Re: Too big 2.6 kernels on SS5
Message-Id: <1108404492.20752.3045.camel@gandalf.uninova.pt>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0502141245530.25663@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0502141245530.25663@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2005-02-14 at 10:53, Meelis Roos wrote:
> I'm trying to test the new framebuffer driver fixes on my SS5-170 (256M 
> RAM). I have Debian unstable installed, running 2.6.8 kernel with 
> initrd.
> 
> I took the lastest 2.6 snapshot and built it. SILO 2.4.8 tells the 
> kernel image is too big. Trimmed the config to minimal normal non-initrd 
> config (ESP, scsi disk and framebuffers static), still too big. Tried 
> with gcc-3.3, gcc-2.95 and gcc-3.4, still too big.
> 
> Tried both vmlinux and arch/sparc/boot/image (what's the difference - 
> why is the later smeller), still no go. Tried uncompressed image, still 
> nothing.
> 
> What am I doing wrong? Is there anything I'm missing? Current .config is 
> below.
> 
> -rwxr-xr-x  1 root root 2647650 2005-02-14 11:22 image
> -rw-r--r--  1 root root  907307 2005-02-12 23:35 vmlinuz-2.4.30-pre1
> -rw-r--r--  1 root root 1110460 2005-02-14 11:22 vmlinuz-2.6.11-rc4
> -rw-r--r--  1 root root  993499 2004-12-28 23:31 vmlinuz-2.6.8-2-sparc32

You should be able to reduce that to the SILO limit (not sure what the
limit is), anyway i use an ugly SILO hack to make it load bigger images.
I'll send it to you if you're interested, however i'm not sure of the
consequences of using it, but it "Works For Me (TM)".
-- 
Pedro Ramalhais <ramalhais@serrado.net>

