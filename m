From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 08 May 2008 16:35:10 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.LNX.4.44L0.0805081231550.2127-100000@iolanthe.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Wed, 7 May 2008, David Brownell wrote:

> On Wednesday 07 May 2008, David Miller wrote:
> > Read the reporter's boot logs. =A0Their system (Sun Fire V100) has OHCI
> > host controllers.
> >=20
> > And right after registerring OHCI is when it hangs:
>=20
> Possibly related:  On an x86 box that's currently running
> 2.6.25 (and unrelated patches), the OHCI controllers are
> dead in the water since they never seem to have left the
> RESET state after a resume from hibernation.

Looks like the "USB: OHCI: host-controller resumes leave root hub=20
suspended" commit (43bbb7e015c4380064796c5868b536437b165615) may need=20
to go into 2.6.25-stable.

I don't think the resume-from-hibernation problem is related to=20
Meelis's soft lockup.

Alan Stern

