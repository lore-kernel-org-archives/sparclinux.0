From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 Jan 2009 20:36:54 +0000
Subject: Re: Unknown CPU in 2.6.29-rc1
Message-Id: <20090116203654.GA27126@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901161249030.2120@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901161249030.2120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 16, 2009 at 10:09:19PM +0200, Meelis Roos wrote:
> > > Now they are after 'Brought up 2 CPUs' together with unknown CPU 
> > > messages.
> > 
> > Can you thr if the following fix the cpu problem.
> 
> It works, thanks! It's now the following as it should be:
> 
> cpu             : TI UltraSparc II  (BlackBird)
> fpu             : UltraSparc II integrated FPU

Thanks for testing.

I would be very suprised if this has any influence on the
other issue you reported.

	Sam
