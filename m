From: Frans van Berckel <fberckel@xs4all.nl>
Date: Thu, 08 Oct 2015 08:41:15 +0000
Subject: Oracle have been working on Sparc Linux
Message-Id: <1444293675.2335.13.camel@xs4all.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

That looks interesting from Oracle about Sparc64.
Forwarding Debian to the Sparc kernel mailing list.

On Thu, 2015-10-08 at 10:06 +0900, John Paul Adrian Glaubitz wrote:
> Hi James!
> 
> > On Oct 8, 2015, at 9:44 AM, James Morris <james.l.morris@oracle.com
> > > wrote:
> > FYI,
> > Oracle developers have been working on Sparc Linux (as some may
> > have noticed from lkml commits).  We've just made an initial cut of
> > this available publicly, for the purposes of sharing it with the
> > wider community.

> This is awesome, thank you! I was actually wondering why there was
> apparently no public activity from Oracle and Fujitsu regarding SPARC
> despite them still selling SPARC-related hard- and software.

> > See https://oss.oracle.com/projects/linux-sparc/
> > There are some mailing lists, a git repo, installable distro etc.
> Superb!

> > I hope that some of this work will be useful to the Debian project,
> > and please feel free to provide us with feedback.

> Absolutely. What should be on top of the priority list is fixing
> binutils and gcc for SPARC. We had two rather nasty bugs in binutils
> [1] and [2].

> While [1] has recently been fixed, thanks to Michael Karcher's
> excellent debugging skills, we still have [2] which needs to be
> fixed. It would be awesome if one of the SPARC experts at Oracle
> could take a look and use the reduced test case, that was again
> provided by Michael Karcher, to help fix the issue.

> There is also another gcc bug which prevents us from using multi-arch
> (32-bit on 64-bit SPARC), but I haven't reported that one yet. Will
> follow up shortly.

> I think it should also be in Oracle's and Fujitsu's interests to get
> the toolchain with binutils and gcc fixed on SPARC as I assume these
> are also used internally for development.

> I will send an email to Debian FTP and the Buildd principal admins to
> ask them to ask SPARC (32 bit) back to ports, also citing your mail
> which proves there is still upstream support for SPARC.

> Thanks a lot for your mail!

> Adrian

> [1] https://sourceware.org/bugzilla/show_bug.cgi?id855
> [2] https://sourceware.org/bugzilla/show_bug.cgi?id019
