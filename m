From: Eric B Munson <emunson@akamai.com>
Date: Thu, 11 Jun 2015 19:55:47 +0000
Subject: Re: [RESEND PATCH V2 0/3] Allow user to request memory to be locked on page fault
Message-Id: <5579E7C3.2020601@akamai.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1433942810-7852-1-git-send-email-emunson@akamai.com>	<20150610145929.b22be8647887ea7091b09ae1@linux-foundation.org>	<5579DFBA.80809@akamai.com> <20150611123424.4bb07cffd0e5bb146cc92231@linux-foundation.org>
In-Reply-To: <20150611123424.4bb07cffd0e5bb146cc92231@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Michal Hocko <mhocko@suse.cz>, Michael Kerrisk <mtk.manpages@gmail.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/11/2015 03:34 PM, Andrew Morton wrote:
> On Thu, 11 Jun 2015 15:21:30 -0400 Eric B Munson
> <emunson@akamai.com> wrote:
>=20
>>> Ditto mlockall(MCL_ONFAULT) followed by munlock().  I'm not
>>> sure that even makes sense but the behaviour should be
>>> understood and tested.
>>=20
>> I have extended the kselftest for lock-on-fault to try both of
>> these scenarios and they work as expected.  The VMA is split and
>> the VM flags are set appropriately for the resulting VMAs.
>=20
> munlock() should do vma merging as well.  I *think* we implemented=20
> that.  More tests for you to add ;)

I will add a test for this as well.  But the code is in place to merge
VMAs IIRC.

>=20
> How are you testing the vma merging and splitting, btw?  Parsing=20
> the profcs files?

To show the VMA split happened, I dropped a printk in mlock_fixup()
and the user space test simply checks that unlocked pages are not
marked as unevictable.  The test does not parse maps or smaps for
actual VMA layout.  Given that we want to check the merging of VMAs as
well I will add this.

>=20
>>> What's missing here is a syscall to set VM_LOCKONFAULT on an=20
>>> arbitrary range of memory - mlock() for lock-on-fault.  It's a=20
>>> shame that mlock() didn't take a `mode' argument.  Perhaps we=20
>>> should add such a syscall - that would make the mmap flag
>>> unneeded but I suppose it should be kept for symmetry.
>>=20
>> Do you want such a system call as part of this set?  I would need
>> some time to make sure I had thought through all the possible
>> corners one could get into with such a call, so it would delay a
>> V3 quite a bit. Otherwise I can send a V3 out immediately.
>=20
> I think the way to look at this is to pretend that mm/mlock.c
> doesn't exist and ask "how should we design these features".
>=20
> And that would be:
>=20
> - mmap() takes a `flags' argument: MAP_LOCKED|MAP_LOCKONFAULT.
>=20
> - mlock() takes a `flags' argument.  Presently that's=20
> MLOCK_LOCKED|MLOCK_LOCKONFAULT.
>=20
> - munlock() takes a `flags' arument.
> MLOCK_LOCKED|MLOCK_LOCKONFAULT to specify which flags are being
> cleared.
>=20
> - mlockall() and munlockall() ditto.
>=20
>=20
> IOW, LOCKED and LOCKEDONFAULT are treated identically and
> independently.
>=20
> Now, that's how we would have designed all this on day one.  And I=20
> think we can do this now, by adding new mlock2() and munlock2()=20
> syscalls.  And we may as well deprecate the old mlock() and
> munlock(), not that this matters much.
>=20
> *should* we do this?  I'm thinking "yes" - it's all pretty simple=20
> boilerplate and wrappers and such, and it gets the interface
> correct, and extensible.
>=20
> What do others think?
>=20

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeefAAAoJELbVsDOpoOa9930P/j32OhsgPdxt8pmlYddpHBJg
PJ4EOYZLoNJ0bWAoePRAQvb9Rd0UumXukkQKVdFCFW72QfMPkjqyMWWOA5BZ6dYl
q3h3FTzcnAtVHG7bqFheV+Ie9ZX0dplTmuGlqTZzEIVePry9VXzqp9BADbWn3bVR
ucq1CFikyEB2yu8pMtykJmEaz4CO7fzCHz6oB7RNX5oHElWmi9AieuUr5eAw6enQ
6ofuNy/N3rTCwcjeRfdL7Xhs6vn62u4nw1Jey6l9hBQUx/ujMktKcn4VwkDXIYCi
+h7lfXWruqOuC+lspBRJO7OL2e6nRdedpDWJypeUGcKXokxB2FEB25Yu31K9sk/8
jDfaKNqmcfgOseLHb+DjJqG6nq9lsUhozg8C17SJpT8qFwQ8q7iJe+1GhUF1EBsL
+DpqLU56geBY6fyIfurOfp/4Hsx2u1KzezkEnMYT/8LkbGwqbq7Zj4rquLMSHCUt
uG5j0MuhmP8/Fuf8OMsIHHUMjBHRjH4rTyaCKxNj3T8uSuLfcnIqEZiJu2qaSA8l
PxpQ6yy2szw9lDxPvxLnh8Rkx+SGEc1ciamyppDTI4LQRiCjMQ7bHAKo0RwAaPJL
ZSHrdlDnUHrYTnd0EZwg0peh8AgkROgxna/pLpfQTeW1g3erqPfbI0Ab8N0cu5j0
8+qA5C+DeSjaMAoMskTG
=82B8
-----END PGP SIGNATURE-----
