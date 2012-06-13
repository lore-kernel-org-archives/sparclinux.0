From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 13 Jun 2012 23:20:46 +0000
Subject: Re: linux-next: build failure after merge of the final tree (pci tree related)
Message-Id: <CAErSpo5Lrk3=hgSd2j+OMLN7rS8kCo5Qr=bPCnDZQdyb=EbEzA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120612145441.400975347f06785d391d0f8f@canb.auug.org.au>
 <CAErSpo6LxpYz_WK2mHPW3RWkOMPLar0KUp1Pgh7shhOdmT49kw@mail.gmail.com> <20120613105041.2d5dcdde6b9cf3dcfba3885d@canb.auug.org.au>
In-Reply-To: <20120613105041.2d5dcdde6b9cf3dcfba3885d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Tue, Jun 12, 2012 at 6:50 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> Hi Bjorn,
>
> On Tue, 12 Jun 2012 09:31:49 -0600 Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
>>
>> Thanks, I folded this typo fix into the relevant patch. =A0I'll rebase
>> "next" today. =A0Sorry for the trouble.
>
> I am not sure what you have done, but now you have a set of duplicated
> commits in your tree including both versions of the one that caused the
> build failure.

This is because of my inept git usage.  I think my "next" branch ended
up with the right bits in it, but the history looked strange because I
fixed the typo in the Yinghai branch, but had a second branch that
depended on the original unfixed branch.

I rebuilt my "next" branch again and I think it's more
straightforward.  And I learned a tiny bit more about git, so thanks
for pointing this out.

Bjorn
