From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 13 Jan 2016 21:44:03 +0000
Subject: [PATCH 2/2] n2rng: Attach on T5/M5, T7/M7 SPARC CPUs
Message-Id: <20160113214403.GD32766@yogzotot>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-crypto@vger.kernel.org
Cc: sparclinux@vger.kernel.org


2. n2rng: documentation, add DT bindings, vendor prefixes

Signed-off-by: Anatoly Pugachev <matorola@gmail.com>

---

 .../bindings/rng/sparc_sun_oracle_rng.txt          | 31 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  2 ++
 2 files changed, 33 insertions(+)

diff --git b/Documentation/devicetree/bindings/rng/sparc_sun_oracle_rng.txt b/Documentation/devicetree/bindings/rng/sparc_sun_oracle_rng.txt
new file mode 100644
index 0000000..bec6b83
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/sparc_sun_oracle_rng.txt
@@ -0,0 +1,31 @@
+HWRNG support for the n2_rng driver
+
+Required properties:
+- compatible : should contain one of the following
+  RNG versions:
+    - 'SUNW,n2-rng' for Niagara 2 Platform (SUN UltraSPARC T2 CPU)
+    - 'SUNW,vf-rng' for Victoria Falls Platform (SUN UltraSPARC T2 Plus CPU)
+    - 'SUNW,kt-rng' for Rainbow/Yosemite Falls Platform (SUN SPARC T3/T4), (UltraSPARC KT/Niagara 3 - development names)
+    more recent systems (after Oracle acquisition of SUN)
+    - 'ORCL,m4-rng' for SPARC T5/M5
+    - 'ORCL,m7-rng' for SPARC T7/M7
+- reg : base address to sample from
+
+Examples:
+/* linux LDOM on SPARC T5-2 */
+        Node 0xf029a4f4
+            .node:  f029a4f4
+            rng-#units:  00000002
+            compatible: 'ORCL,m4-rng'
+            reg:  0000000e
+            name: 'random-number-generator'
+
+/* solaris on SPARC M7-8 */
+        Node 0xf028c08c
+            rng-#units:  00000003
+            compatible: 'ORCL,m7-rng'
+            reg:  0000000e
+            name:  'random-number-generator'
+
+
+PS: see as well prtconfs.git by DaveM
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 55df1d4..6b8007f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -166,6 +166,7 @@ opencores   OpenCores.org
 option Option NV
 ortustech      Ortus Technology Co., Ltd.
 ovti   OmniVision Technologies
+ORCL   Oracle Corporation
 panasonic      Panasonic Corporation
 parade Parade Technologies Inc.
 pericom        Pericom Technology Inc.
@@ -221,6 +222,7 @@ st  STMicroelectronics
 ste    ST-Ericsson
 stericsson     ST-Ericsson
 synology       Synology, Inc.
+SUNW   Sun Microsystems, Inc
 tbs    TBS Technologies
 tcl    Toby Churchill Ltd.
 thine  THine Electronics, Inc.
