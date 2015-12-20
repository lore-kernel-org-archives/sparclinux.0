From: "Dmitry V. Levin" <ldv@altlinux.org>
Date: Sun, 20 Dec 2015 23:31:44 +0000
Subject: Re: using ptrace to cancel a syscall on sparc
Message-Id: <20151220233144.GA23664@altlinux.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
List-Id: <sparclinux.vger.kernel.org>
References: <20151220054754.GZ11489@vapier.lan>
In-Reply-To: <20151220054754.GZ11489@vapier.lan>
To: sparclinux@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 20, 2015 at 12:47:54AM -0500, Mike Frysinger wrote:
> i've been playing with ptrace on sparc and trying to use it to watch and
> cancel specific syscalls.  i have this working for other arches already.
[...]
> i'm having trouble with canceling of the syscall itself.  seems like
> no matter what i stuff into o0, the kernel executes the unlink.  i've
> tried tracing arch/sparc/kernel/syscalls.S and kernel/head_64.S, the
> the entry is linux_sparc_syscall32 which calls linux_syscall_trace32,
> but it seems like the o0 stuff doesn't seem to work for me.  my sparc
> asm foo isn't strong enough to figure out what's going wrong :/.

Yes, sparc is odd in this respect: whatever you write to u_regs[] on
entering syscall, it doesn't affect syscall number or syscall arguments.


--=20
ldv

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJWdzpgAAoJEAVFT+BVnCUIB+gQAK2Q128ivmCQEaphmepMDVco
1NB+R5Ch6kuMy0tbUmUe107CWfrIb/+QEhTWQ0J5E/OST4lgjP4ocIRAN5jRkp1Z
pL73eBdwQ9zhunjOV9PNs/bCUEifiRTNfkjRiiCRp1kN4k/qBnUJeA3pgytboCex
TE+L1hrVl4eshO+K5NitJkMDLZsQoHCDHb/CB21gGz+i/pWa/Fplz6oQ1AgCNpP1
QL+yUyXti7Oc4NC56jWnFm4+nEKP+4AStNx1d9Y47LSAGiWdYE3a4m+xU9fRd3gK
wUe6tlRq238lVbPwDgnHfuQ3Uto/Iro1Rslkf9LDeaoNoEIBZND0WBJTapPk7yzL
LWteYzkPkzTlL51rHnu25gPko6T7yZcvos5116b+O7TFhOU5TqGju1lsu0GaVXAC
lOBKzVJaHStaL7+T2vbvhjNF3zW8CHHW4zM/6uc5xV2NAePEMAkgIymWwN5zZixs
CAEgo8tcP//pOwb7Di2rrEY7Hh6eMUvs36bs4Kztli80DXLpnqy4isoBMf0WGBwu
MJwI/ullMSSbMsk9forASbl1sP4e+JDmpJzlSc+DIVGaJsZLZ0esNuEdSkOYY+qo
8H2q5Ftzqix3hf9Jpx0vfV+Q/n1X9hLVV8nxynw5vD0DiR4m3YbLkuJ1FrqmU0Wj
6L4cUSnRs847ypI3GVMf
=f9+L
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
