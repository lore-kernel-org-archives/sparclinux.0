From: Tadeusz Struk <tadeusz.struk@intel.com>
Date: Wed, 04 May 2016 20:02:45 +0000
Subject: Re: [crypto / sparc64] cryptomgr_test OOPS
Message-Id: <06c0b4f8-becf-25f3-109a-e1500f11626a@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqyMwme53etMrnx3xkpGsR6-W88RHLA3nh0GCGAzcz5=Fw@mail.gmail.com>
 <20160503.123301.298039059390449291.davem@davemloft.net>
 <CADxRZqzynaTAD+vcJwW2ueGnQyy=tQAJq2TvTT-_pZG26=_ZLQ@mail.gmail.com>
In-Reply-To: <CADxRZqzynaTAD+vcJwW2ueGnQyy=tQAJq2TvTT-_pZG26=_ZLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatoly Pugachev <matorola@gmail.com>, David Miller <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org

Hi Anatoly,
On 05/04/2016 12:10 PM, Anatoly Pugachev wrote:
> we're using 4.5.2 debian kernel here without this problem. I'm not
> sure I would be able to bisect, never did it before, but I could
> try...

On 4.5.2 could you try "modprobe rsa"

-- 
TS
