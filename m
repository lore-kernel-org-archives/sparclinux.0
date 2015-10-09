From: James Morris <jmorris@namei.org>
Date: Fri, 09 Oct 2015 01:52:35 +0000
Subject: Re: Oracle have been working on Sparc Linux
Message-Id: <alpine.LRH.2.20.1510091242130.7147@namei.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1444293675.2335.13.camel@xs4all.nl>
In-Reply-To: <1444293675.2335.13.camel@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 8 Oct 2015, Frans van Berckel wrote:

> On Thu, 2015-10-08 at 13:17 +0200, Frans van Berckel wrote:
> > On Thu, Oct 08, 2015 at 10:41:15AM +0200, Frans van Berckel wrote:
> 
> <snip>
> 
> > > Forwarding Debian to the Sparc kernel mailing list.
> > 
> > > BTW, the item of interest there WRT kernel is the source control
> > > link
> > > there: https://oss.oracle.com/git/?p=linux-uek.git;a=tree
> > 
> > > which says
> > 
> > > 403 Forbidden - Reading tree failed
> 
> <snip>
> 
> > But it got to be fixed, true.
> 
> I spoke today with Keshav Sharma, and solve the error.

Sorry about that.

As mentioned, this release is to share our work so far with the community 
and we hope it will be useful.

There's a downloadable ISO:
https://oss.oracle.com/linux-sparc/isos/

which is a yum based distro, which can be installed on bare metal or in an 
ldom.  All the source RPMS are available, as well as the kernel git tree 
git://oss.oracle.com/git/linux-uek.git.

See the release notes for general info:
https://oss.oracle.com/linux-sparc/docs/RELEASE-NOTES-1.0-en.html

Some additions and packages updates are currently being released, 
including git and rpmbuild.

We also have grub2 support coming soon.

Feedback is welcome!


- James
-- 
James Morris
<jmorris@namei.org>

