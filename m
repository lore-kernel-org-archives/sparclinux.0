From: Jima <jima@beer.tclug.org>
Date: Tue, 03 Jan 2006 14:41:24 +0000
Subject: Re: 2.4 Kernel support for SPARC 4m, SMP ???
Message-Id: <Pine.LNX.4.63.0601030839180.9025@beer.tclug.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20060102154605.A1715@daves-domain.net>
In-Reply-To: <20060102154605.A1715@daves-domain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2 Jan 2006, Dave Lee wrote:
> Can anyone advise on 2.4 kernel SMP support for SPARC 4m (32 bit)?
>
> I've been running 2.2 on an SS20, dual SuperSparc, as a headless server
> and router for a several years with great success.
>
> Now we need to migrate to the 2.4 kernel .... Will it work with 4m/SMP ??
>
> Any comments/advice greatly appreciated.

  Wow.  And I thought I took my migrations slowly...
  Last I checked/heard, yes, sun4m SMP works under 2.4 kernels.  However, 
it's quite b0rk3d under 2.6, so that's probably as far as you're gonna go 
anytime soon, if not ever.

      Jima
