From: Narayan Newton <nnewton@osuosl.org>
Date: Tue, 20 Mar 2007 20:41:10 +0000
Subject: Re: [Systems] Re: Oops in tcp_sendmsg on T[12]000
Message-Id: <460046E6.7030808@osuosl.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1818c1980703052246p5af31178p70296e156b06511a@mail.gmail.com>
In-Reply-To: <1818c1980703052246p5af31178p70296e156b06511a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

I have been running netcat since around 10 AM yesterday morning on a
patched kernel with netfilter enabled and have been unable to trigger
this bug. Thank you for your work on this issue!

--=20
Narayan Newton
OSU Open Source Lab



David Miller wrote:
> From: Narayan Newton <nnewton@osuosl.org>
> Date: Mon, 12 Mar 2007 16:58:56 -0700
>=20
>> I have been working on the same server/issue as Mike. We have found that
>> our kernel without Netfilter support does not have this issue, but the
>> moment you enable it in the kernel config this bug is triggered.
>> Attached are the two kernel configs. The only difference is
>> CONFIG_NETFILTER=3Dy
>>
>> Kernel version: 2.6.21-rc2
>=20
> Ok, I think the following patch is the bug fix.  I'm running a bunch
> of further stress testing to make sure this is indeed the cause of
> these crashes.
>=20
> Let me know if you can still trigger the bug with this patch
> applied, thanks!
>=20
> Assuming all goes well I'll push this upstream to Linus and
> also to the -stable 2.6.x branches.
>=20
> [SPARC64]: store-init needs trailing membar.
>=20
> The manual says that it is required and we actually have crash reports
> where loads see stale data due to not having membars here.
>=20
> In one case the networking does:
>=20
> 	memset(skb, 0, offsetof(struct sk_buff, truesize));
>=20
> and then some code later checks skb->nohdr for zero, but it's still
> the value that was there before the memset().
>=20
> Signed-off-by: David S. Miller <davem@davemloft.net>
>=20
> diff --git a/arch/sparc64/lib/NGbzero.S b/arch/sparc64/lib/NGbzero.S
> index e86baec..f10e452 100644
> --- a/arch/sparc64/lib/NGbzero.S
> +++ b/arch/sparc64/lib/NGbzero.S
> @@ -88,6 +88,7 @@ NGbzero_loop:
>  	bne,pt		%xcc, NGbzero_loop
>  	 add		%o0, 64, %o0
> =20
> +	membar		#Sync
>  	wr		%o4, 0x0, %asi
>  	brz,pn		%o1, NGbzero_done
>  NGbzero_medium:
> diff --git a/arch/sparc64/lib/NGmemcpy.S b/arch/sparc64/lib/NGmemcpy.S
> index 8e522b3..66063a9 100644
> --- a/arch/sparc64/lib/NGmemcpy.S
> +++ b/arch/sparc64/lib/NGmemcpy.S
> @@ -247,6 +247,8 @@ FUNC_NAME:	/* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen */
>  	/* fall through */
> =20
>  60:=09
> +	membar		#Sync
> +
>  	/* %o2 contains any final bytes still needed to be copied
>  	 * over. If anything is left, we copy it one byte at a time.
>  	 */
> diff --git a/arch/sparc64/lib/NGpage.S b/arch/sparc64/lib/NGpage.S
> index 7d7c3bb..8ce3a0c 100644
> --- a/arch/sparc64/lib/NGpage.S
> +++ b/arch/sparc64/lib/NGpage.S
> @@ -41,6 +41,7 @@ NGcopy_user_page:	/* %o0=DEst, %o1=3Dsrc, %o2=3Dvaddr */
>  	subcc		%g7, 64, %g7
>  	bne,pt		%xcc, 1b
>  	 add		%o0, 32, %o0
> +	membar		#Sync
>  	retl
>  	 nop
> =20
> @@ -63,6 +64,7 @@ NGclear_user_page:	/* %o0=DEst, %o1=3Dvaddr */
>  	subcc		%g7, 64, %g7
>  	bne,pt		%xcc, 1b
>  	 add		%o0, 32, %o0
> +	membar		#Sync
>  	retl
>  	 nop
> =20
