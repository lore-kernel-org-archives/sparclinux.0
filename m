From: Martin <inkubus@interalpha.co.uk>
Date: Thu, 07 May 2009 01:00:35 +0000
Subject: Re: sparc/debian/linux procedures
Message-Id: <1241658035.3766.204.camel@white.sevalidation.com>
List-Id: <sparclinux.vger.kernel.org>
References: <49FF4180.9000407@eng.wayne.edu>
In-Reply-To: <49FF4180.9000407@eng.wayne.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

[ Apologies for the cross post ]
On Mon, 2009-05-04 at 15:26 -0400, Brian Thompson wrote:
> All,
<snip>
> It's my understanding that there are a team of people who are focused
> on the sparc kernel itself (which is used by Debian as well as some of
> the other distributions - Aurora, etc).
This is a subset of the kernel developers.  David Miller is (I believe)
the key man.

> It's also my understanding that there are a team of people who are
> focused on making sure that the sparc port of Debian works properly
> as a complete Debian OS distribution for sparc.
It's more of a loose affiliation, but yes, these are some of the Debian developers on the debian-sparc list.

> In addition, I understand that there's also a team of people who are
> focused on making sure that the Debian distribution as whole
> (non-arch specific) functions properly and that changes on one port
> don't end up inadvertently causing problems for other Debian ports.
Again, more a loose affiliation - this is essentially the work of the
Debian developers.  A small number of developers have responsibility for
over all integration (i.e. the release team, buildd maintainers, etc.)
but most work is done on a package by package basis with a small number
of folks working on each (often one or two).

> Likewise I understand that there's a team of people who are focused
> on making sure that the linux kernel as a whole functions properly and
> that changes specific to one arch don't end up inadvertently causing
> problems for other linux kernel archs.
This is, in general the Linux kernel developers; although, again, their responsibilities and organisational structure vary.

> My question is - when I find things that worked in Ubuntu sparc
> but not on Debian, what is the proper procedure for resolving the
> issue? Is there a checklist or flowchart anywhere public that should
> be followed when issues are found?
> 
> I'm guessing the first step is probably to determine whether it's a
> kernel issue or an issue external to the kernel so that a bug report can
> be filed with the correct team (while also checking to see if the issue
> has already been reported), but again that's just a guess.
A general procedure might be:

1. Identify which package(s) are causing the problem.
2. Attempt to identify what conditions / factors / circumstances trigger
the issue.  All the normal rules about writing bug reports apply.
3. File a bug report against the relevant Debian package.
4. Assist the package maintainer with any follow up queries.

If you have time and access to a version of the package that does work,
it might be helpful to track down which differences are causing the
problem, and if possible, submit a patch.  Certainly, including a
reference / pointer to the nearest version of Ubuntu package that works
would be helpful.

If the bug turns out to be something that is not specific to Debian and
is a more general problem then the packages maintainer may forward it
("upstream") to the main developers for that package.

> Any guidance would be greatly appreciated.
Does the above help?  I'm far from an expert on this; I'm just an
end-user, but the above procedure has worked for me.

HTH

Cheers,
 - Martin


