From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 02 Nov 2017 05:41:40 +0000
Subject: Re: [PATCH] sparc: pass endianness info to sparse
Message-Id: <20171102054140.GA1454@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20171031172210.9990-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20171031172210.9990-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Luc.

On Tue, Oct 31, 2017 at 06:22:10PM +0100, Luc Van Oostenryck wrote:
> sparc is big-endian only but sparse assumes the same endianness
> as the building machine.
> This is problematic for code which expect __BYTE_ORDER__ being
> correctly predefined by the compiler which sparse can then
> pre-process differently from what gcc would, depending on the
> building machine endianness.
> 
> Fix this by letting sparse know about the architecture endianness.
> 
> To: David S. Miller <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  arch/sparc/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
> index 8496a074b..ef1598f5a 100644
> --- a/arch/sparc/Makefile
> +++ b/arch/sparc/Makefile
> @@ -55,6 +55,8 @@ endif
>  
>  endif
>  
> +CHECKFLAGS     += -mbig-endian
> +

You have added a new assignment to CHECKFLAGS because this
options is the same for sparc32 and sparc64, which is fine.

But could you then in the same patch
also move the assingmnet to -D__sparc__ this place, as this is also
a common option for sparc32 and sparc64.
As it is after your patch we have common options duplicated (__sparc__)
and in their own assignment (-mbig-endian).
This is inconsistent and may confuse the next reader.

	Sam
