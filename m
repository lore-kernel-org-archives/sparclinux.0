From: "David S. Miller" <davem@redhat.com>
Date: Tue, 30 Dec 2003 21:36:45 +0000
Subject: Re: [2.6.0] Huge TLB != 4M Fix
Message-Id: <20031230133645.7ab2f94e.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20031230194550.0b20a913@snowdrop.home>
In-Reply-To: <20031230194550.0b20a913@snowdrop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 30 Dec 2003 19:45:50 +0000
Ciaran McCreesh <ciaranm@gentoo.org> wrote:

> With 2.6.0 (plus Keith's patches) on sparc64, I get compile errors if
> CONFIG_HUGETLB_PAGE_SIZE is set to other than 4MB:
 ...
> The attached patch fixes this.

Patch applied, thanks Ciaran.
