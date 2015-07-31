From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 31 Jul 2015 09:17:04 +0000
Subject: Re: Debian drops support for sparc
Message-Id: <20150731091704.GA23378@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150730140453.GA25014@ravnborg.org>
In-Reply-To: <20150730140453.GA25014@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jul 30, 2015 at 02:53:33PM -0700, David Miller wrote:
> > The problem is that numerous other issues - haven't.
> 
> It would be nice to narrow things down to the real issues.

Well, let me try to clarify what I've already said:

* More people have to become what is known as sparc porters in Debian. That
  means being involved in making sure sparc package build failures in Debian
  are attended to - as opposed to currently listed 1 single person.

* The default compiler is apparently stuck on an old version, or was at some
  point? I can't verify that at https://packages.debian.org/gcc Someone
  should investigate what went wrong there - judging by the previous
  difference in opinions regarding whether 32-bit userland is viable,
  it would probably be necessary to take that to the debian-gcc list

* The buildd kernels haven't been stable enough. Someone should talk to
  the buildd maintainers at sparc@buildd.debian.org to see what the status
  is.

Perhaps this all seems like not 'real' issues to kernel people, but there's
nothing more real for Debian sparc users and buildd maintainers than the
issue of nobody being around in the standard Debian communication channels
to hear them scream :)

-- 
     2. That which causes joy or happiness.
