From: Pedro Ramalhais <ramalhais@serrado.net>
Date: Mon, 14 Feb 2005 19:50:15 +0000
Subject: Re: Too big 2.6 kernels on SS5
Message-Id: <1108410614.20752.3519.camel@gandalf.uninova.pt>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0502141245530.25663@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0502141245530.25663@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2005-02-14 at 18:17, Keith M Wesolowski wrote:
> On Mon, Feb 14, 2005 at 06:08:12PM +0000, Pedro Ramalhais wrote:
> 
> > You should be able to reduce that to the SILO limit (not sure what the
> > limit is), anyway i use an ugly SILO hack to make it load bigger images.
> > I'll send it to you if you're interested, however i'm not sure of the
> > consequences of using it, but it "Works For Me (TM)".
> 
> The limit is 2.5MB, that is, 2.5 * 1024 * 1024 bytes.
> 
> If you're referring to my load address change, the impact is that it
> only works on some machines.  I think the ss10/20 are ok, not sure
> about any others.  A first-order improvement might be to have PIC SILO
> and use a small linker to relocate it before loading a kernel.  I
> remember looking at this, as well as the possibility of loading the
> kernel at a different address like sparc64, and basically concluded
> that (a) it is hard, and (b) it is a waste of time.  If you want to
> use machines that don't map memory above 3MB, just make smaller
> kernels.

Yep, it's your change. It works for me on something like a SS4 clone.
-- 
Pedro Ramalhais <ramalhais@serrado.net>

