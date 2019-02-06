From: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 06 Feb 2019 11:58:18 +0000
Subject: Re: [PATCH net-next v5 11/12] socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD suffixes
Message-Id: <87o97pku1x.fsf@concordia.ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20190202153454.7121-1-deepa.kernel@gmail.com> <20190202153454.7121-12-deepa.kernel@gmail.com>
In-Reply-To: <20190202153454.7121-12-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Deepa Dinamani <deepa.kernel@gmail.com>, davem@davemloft.net, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, ccaulfie@redhat.com, deller@gmx.de, paulus@samba.org, ralf@linux-mips.org, rth@twiddle.net, cluster-devel@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org

Deepa Dinamani <deepa.kernel@gmail.com> writes:

> SO_RCVTIMEO and SO_SNDTIMEO socket options use struct timeval
> as the time format. struct timeval is not y2038 safe.
> The subsequent patches in the series add support for new socket
> timeout options with _NEW suffix that will use y2038 safe
> data structures. Although the existing struct timeval layout
> is sufficiently wide to represent timeouts, because of the way
> libc will interpret time_t based on user defined flag, these
> new flags provide a way of having a structure that is the same
> for all architectures consistently.
> Rename the existing options with _OLD suffix forms so that the
> right option is enabled for userspace applications according
> to the architecture and time_t definition of libc.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Acked-by: Willem de Bruijn <willemb@google.com>
> Cc: ccaulfie@redhat.com
> Cc: deller@gmx.de
> Cc: paulus@samba.org
> Cc: ralf@linux-mips.org
> Cc: rth@twiddle.net
> Cc: cluster-devel@redhat.com
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> ---
>  arch/alpha/include/uapi/asm/socket.h   | 7 +++++--
>  arch/mips/include/uapi/asm/socket.h    | 6 ++++--
>  arch/parisc/include/uapi/asm/socket.h  | 6 ++++--
>  arch/powerpc/include/uapi/asm/socket.h | 4 ++--

The powerpc changes look OK to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/include/uapi/asm/socket.h b/arch/powerpc/include/uapi/asm/socket.h
> index 94de465e0920..12aa0c43e775 100644
> --- a/arch/powerpc/include/uapi/asm/socket.h
> +++ b/arch/powerpc/include/uapi/asm/socket.h
> @@ -11,8 +11,8 @@
>  
>  #define SO_RCVLOWAT	16
>  #define SO_SNDLOWAT	17
> -#define SO_RCVTIMEO	18
> -#define SO_SNDTIMEO	19
> +#define SO_RCVTIMEO_OLD	18
> +#define SO_SNDTIMEO_OLD	19
>  #define SO_PASSCRED	20
>  #define SO_PEERCRED	21
>  
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index 2713e0fa68ef..c56b8b487c12 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -30,8 +30,8 @@
>  #define SO_PEERCRED	17
>  #define SO_RCVLOWAT	18
>  #define SO_SNDLOWAT	19
> -#define SO_RCVTIMEO	20
> -#define SO_SNDTIMEO	21
> +#define SO_RCVTIMEO_OLD	20
> +#define SO_SNDTIMEO_OLD	21
>  #endif
>  
>  /* Security levels - as per NRL IPv6 - don't actually do anything */
> @@ -116,6 +116,8 @@
>  
>  #if !defined(__KERNEL__)
>  
> +#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
> +#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
>  #if __BITS_PER_LONG = 64 || (defined(__x86_64__) && defined(__ILP32__))
>  /* on 64-bit and x32, avoid the ?: operator */
>  #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
