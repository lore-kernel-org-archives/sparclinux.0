From: Vladimir Volovich <vvv@vsu.ru>
Date: Fri, 25 Mar 2005 20:14:58 +0000
Subject: Re: running 2.6.* on sparc with Creator 3D and ATY Mach64
Message-Id: <878y4b8ou5.fsf@vvv.vsu.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <87vf7f7nws.fsf@video.uic.vsu.ru>
In-Reply-To: <87vf7f7nws.fsf@video.uic.vsu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

"DSM" = David S Miller writes:

 >> I waited for a while after the boot in the hope that X will
 >> successfully start, despite the absence of framebuffer console,
 >> but it did not happen.... (though the screen became just black
 >> after X attempted to initialize)
 >> 
 >> Is there a way to make the 2.6.* kernel use the Creator 3D on
 >> 2.6.11, in the presence of Mach64?

 DSM> X is going to not start successfully, unfortunately.  It is
 DSM> because of the PCI graphics card.  So when playing around with
 DSM> the kernel console, you may want to adjust the configuration so
 DSM> that X does not try to startup.

Thanks for your answer; it is strange that when running kernel 2.4.27,
i have no problems with running X (and also the framebuffer console
works perfectly too).

Is this a limitation introduced into 2.6.* kernels? Is it going to be
resolved?

Best,
v.

