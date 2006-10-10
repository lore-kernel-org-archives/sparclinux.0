From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 10 Oct 2006 15:43:13 +0000
Subject: [PATCH 0/4] fix sparc32 modpost warnings
Message-Id: <20061010154313.GA30909@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

These are my attempts to fix most of the "Section mismatch" warnings
comming from modpost on sparc32. All patches are against 2.6.19-rc1.

There are a few left originating from head.S. I do not know how to
fix those. Any hints are welcome :)

Thanks,
-- 
Martin
