From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 25 Mar 2005 17:39:28 +0000
Subject: Re: running 2.6.* on sparc with Creator 3D and ATY Mach64
Message-Id: <20050325093928.7cd0138e.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87vf7f7nws.fsf@video.uic.vsu.ru>
In-Reply-To: <87vf7f7nws.fsf@video.uic.vsu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 25 Mar 2005 18:20:19 +0300
Vladimir Volovich <vvv@vsu.ru> wrote:

> I waited for a while after the boot in the hope that X will
> successfully start, despite the absence of framebuffer console, but it
> did not happen.... (though the screen became just black after X
> attempted to initialize)
> 
> Is there a way to make the 2.6.* kernel use the Creator 3D on 2.6.11,
> in the presence of Mach64?

X is going to not start successfully, unfortunately.  It is because
of the PCI graphics card.  So when playing around with the kernel
console, you may want to adjust the configuration so that X does not
try to startup.
