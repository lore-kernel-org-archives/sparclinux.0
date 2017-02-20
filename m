From: Borislav Petkov <bp@alien8.de>
Date: Mon, 20 Feb 2017 11:17:27 +0000
Subject: Re: [PATCH 2/4] x86: convert threshold_bank.cpus from atomic_t to refcount_t
Message-Id: <20170220111727.7vohleiu2btmsx3g@pd.tnic>
List-Id: <sparclinux.vger.kernel.org>
References: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
 <1487588781-15123-3-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1487588781-15123-3-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Elena Reshetova <elena.reshetova@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, x86@kernel.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, tony.luck@intel.com, hpa@zytor.com, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>

On Mon, Feb 20, 2017 at 01:06:19PM +0200, Elena Reshetova wrote:
> refcount_t type and corresponding API should be
> used instead of atomic_t when the variable is used as
> a reference counter. This allows to avoid accidental
> refcounter overflows that might lead to use-after-free
> situations.
>=20
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>

That SOB chain tells me that you wrote the patch and Hans, Kees and
David handled it in some way and the last one - David - is sending it to
me. It doesn't look like that though.

So what are you trying to express with it?

Documentation/process/submitting-patches.rst has some info on the whole
SOB deal:

11) Sign your work =E2=80=94 the Developer's Certificate of Origin
----------------------------------------------------------
..


--=20
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
