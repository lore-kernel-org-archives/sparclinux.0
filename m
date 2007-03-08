From: "Alex Deucher" <alexdeucher@gmail.com>
Date: Thu, 08 Mar 2007 14:26:41 +0000
Subject: Re: Sunfire v880
Message-Id: <a728f9f90703080626w66fe9dc8kebe98ead4c822053@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
In-Reply-To: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 3/7/07, David Miller <davem@davemloft.net> wrote:
> From: "Alex Deucher" <alexdeucher@gmail.com>
> Date: Wed, 7 Mar 2007 17:55:31 -0500
>
> >  I built 2.6.20.1 and tried to netboot it.  I got the same thing
> > "booting linux..." then nothing.  adding -p did not provide any
> > additional output.
>
> This sucks, I wish I had one of these machines so I could
> keep them from breaking as these kinds of bugs are nearly
> impossible to fix remotely in a sane manner.
>
> Hohum... let's try to see where it dies, add this patch and
> reboot with "-p" again, thanks.  BTW, you also could certainly
> add tracing printk() statements like this too in order to help
> narrow down where it dies.  This is just debugging monkey work.
>

Your patch doesn't produce any additional output (even with -p) on
2.6.20.1.  All I get is "booting linux..." and that's it.

Alex
