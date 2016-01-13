From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 13 Jan 2016 21:43:18 +0000
Subject: [PATCH 0/2] n2rng: Attach on T5/M5, T7/M7 SPARC CPUs
Message-Id: <20160113214318.GB32766@yogzotot>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-crypto@vger.kernel.org
Cc: sparclinux@vger.kernel.org

This patch adds support for recent oracle hardware (T5/M5, T7/M7 SPARC CPUs=
),
so n2_rng driver would work on them.

1. n2rng: Attach on T5/M5, T7/M7 SPARC CPUs
2. n2rng: documentation, add DT bindings, vendor prefixes

PS: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=809815#32

Signed-off-by: Anatoly Pugachev <matorola@gmail.com>

---

 .../bindings/rng/sparc_sun_oracle_rng.txt          | 31 ++++++++++++++++++=
++++
 .../devicetree/bindings/vendor-prefixes.txt        |  2 ++
 {a =3D> b}/drivers/char/hw_random/n2-drv.c           | 10 +++++++
 3 files changed, 43 insertions(+)
