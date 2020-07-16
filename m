From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 16 Jul 2020 11:54:26 +0000
Subject: Re: [PATCH v2 0/5] crypto: add sha256() function
Message-Id: <20200716115426.GD31166@gondor.apana.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20200708163943.52071-1-ebiggers@kernel.org>
In-Reply-To: <20200708163943.52071-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Biggers <ebiggers@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, alsa-devel@alsa-project.org, linux-efi@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, Guenter Roeck <groeck@chromium.org>, mptcp@lists.01.org, Ard Biesheuvel <ardb@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>

On Wed, Jul 08, 2020 at 09:39:38AM -0700, Eric Biggers wrote:
> This series adds a function sha256() to the sha256 library so that users
> who want to compute a hash in one step can just call sha256() instead of
> sha256_init() + sha256_update() + sha256_final().
> 
> Patches 3-5 then convert some users to use it.
> 
> Changed v1 => v2:
>   - Added sparc patch to fix a build breakage caused by a
>     static variable already named "sha256".
>   - Added Reviewed-by, Acked-by, and Tested-by tags.
> 
> Eric Biggers (5):
>   crypto: sparc - rename sha256 to sha256_alg
>   crypto: lib/sha256 - add sha256() function
>   efi: use sha256() instead of open coding
>   mptcp: use sha256() instead of open coding
>   ASoC: cros_ec_codec: use sha256() instead of open coding
> 
>  arch/sparc/crypto/sha256_glue.c          | 14 ++++++------
>  drivers/firmware/efi/embedded-firmware.c |  9 +++-----
>  include/crypto/sha.h                     |  1 +
>  lib/crypto/sha256.c                      | 10 +++++++++
>  net/mptcp/crypto.c                       | 15 +++----------
>  sound/soc/codecs/cros_ec_codec.c         | 27 ++----------------------
>  6 files changed, 26 insertions(+), 50 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
