From: Jurij Smakov <jurij@wooyd.org>
Date: Thu, 12 Jan 2006 08:04:17 +0000
Subject: Re: strace broken on SPARC64
Message-Id: <Pine.LNX.4.63.0601112357450.4359@bobcat>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463804416-683745970-1137053057=:4359"
List-Id: <sparclinux.vger.kernel.org>
References: <1136767843.9208.15.camel@duncow>
In-Reply-To: <1136767843.9208.15.camel@duncow>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804416-683745970-1137053057=:4359
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Mon, 9 Jan 2006, Richard Mortimer wrote:

> On Mon, 2006-01-09 at 12:53 -0800, David S. Miller wrote:
> I tried using %l2 as suggested by Luis and that works for me.
[..]
> diff --git a/arch/sparc64/kernel/entry.S b/arch/sparc64/kernel/entry.S
> index 11a8484..d9b9f32 100644
> --- a/arch/sparc64/kernel/entry.S
> +++ b/arch/sparc64/kernel/entry.S
> @@ -1657,13 +1657,10 @@ ret_sys_call:
>        /* Check if force_successful_syscall_return()
>         * was invoked.
>         */
> -       ldub            [%curptr + TI_SYS_NOERROR], %l0
> -       brz,pt          %l0, 1f
> -        nop
> -       ba,pt           %xcc, 80f
> +       ldub            [%curptr + TI_SYS_NOERROR], %l2
> +       brnz,a,pn       %l2, 80f
>         stb            %g0, [%curptr + TI_SYS_NOERROR]
>
> -1:
>        cmp             %o0, -ERESTART_RESTARTBLOCK
>        bgeu,pn         %xcc, 1f
>         andcc          %l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT), %l6

Hi,

I can confirm that this patch (after rediffing) fixes strace problems and 
does not seem to introduce any negative side effects. Actual patch which 
I've used for testing (applied to 2.6.15) is attached.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
---1463804416-683745970-1137053057=:4359
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=sparc.patch
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename=sparc.patch

LS0tIGEvZGViaWFuL2FyY2gvc3BhcmMvZGVmaW5lcwkyMDA1LTEwLTMwIDE3
OjM3OjA2LjAwMDAwMDAwMCAtMDgwMA0KKysrIGIvZGViaWFuL2FyY2gvc3Bh
cmMvZGVmaW5lcwkyMDA1LTEwLTMwIDE1OjEwOjIxLjAwMDAwMDAwMCAtMDgw
MA0KQEAgLTEsNyArMSwxMSBAQA0KIFtiYXNlXQ0KIGNvbXBpbGVyOiBnY2Mt
My4zDQotZmxhdm91cnM6IHNwYXJjNjQgc3BhcmM2NC1zbXANCitmbGF2b3Vy
czoNCisgc3BhcmM2NA0KKyBzcGFyYzY0LXNtcA0KK2tlcm5lbC1hcmNoOiBz
cGFyYzY0DQoga3BrZy1zdWJhcmNoOiBzcGFyYzY0DQora2VybmVsLWhlYWRl
ci1kaXJzOiBzcGFyYzY0DQogc3VnZ2VzdHM6IHNpbG8sIGZkdXRpbHMNCiAN
CiBbc3BhcmM2NF0NCg==

---1463804416-683745970-1137053057=:4359--
