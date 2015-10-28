From: David Miller <davem@davemloft.net>
Date: Wed, 28 Oct 2015 00:43:53 +0000
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-Id: <20151027.180011.1597667162481700758.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAGRGNgXV+RJvjOBe351HyguYkonQ8F=CM3uZTijcqoQg6ArAcw@mail.gmail.com>
 <20151027234018.GA48779@linux.vnet.ibm.com>
 <CAGRGNgVvvcjHFjU4H1wnj6bGy69X19d-xR9O+Xc-p-TmtPxNgQ@mail.gmail.com>
In-Reply-To: <CAGRGNgVvvcjHFjU4H1wnj6bGy69X19d-xR9O+Xc-p-TmtPxNgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 28 Oct 2015 10:43:35 +1100

> You'll be CCing the maintainers of each architecture on the patches to
> add the functions, so if they do have specific requirements, I'm sure
> they'll let you know or provide patches.

People miss things, maintainers get busy, so while a CC: is important
and appreciated, it doesn't ensure a correct implementation is likely
to result.

Personally, I'd much rather my arch stop building so I have to go in
there to explicitly look at the reason why and make sure I fill in the
missing pieces properly and accurately.
