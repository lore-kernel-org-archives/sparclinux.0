From: "Peter Lieven" <pl@dlh.net>
Date: Fri, 28 Sep 2007 20:42:25 +0000
Subject: PATCH: tcp rfc 2385 security/bugfix for sparc64
Message-Id: <23966.84.62.25.8.1191012145.squirrel@cs1.dlh.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, davem@davemloft.net
Cc: alan@lxorguk.ukuu.org.uk, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org

TCP MD5 signatures on sparc64 (big-endian) completely fail on current
kernel releases in interoperability with Cisco/Foundry or other
little-endian linux systems.

The root cause is a cast in the return statement of tcp_v4_md5_do_lookup,
where a tcp4_md5sig_key is casted onto tcp_md5sig_key without proper
conversion. On little-endian systems the upper 8 bits are cut of which
yields the expected behaviour. However, on big-endian systems (like
sparc64) only the most significant 8 bits are preserved. Since
TCP_MD5SIG_MAXKEYLEN is 80, this always yields 0.

In the calculation of the md5 signature afterwards the key is therefore
not appended to the tcp segment which could result in a security problem
since only the presence of a md5 signature is checked, and the key itself
doesn't matter.

--- linux.old/include/net/tcp.h 2007-09-28 21:43:26.000000000 +0200 +++
linux/include/net/tcp.h     2007-09-28 21:45:35.000000000 +0200 @@ -1055,6
+1055,7 @@ static inline void clear_all_retrans_hin
 struct crypto_hash;

 /* - key database */
+/* this should be compatible with the head of the following two structs */
 struct tcp_md5sig_key {
        u8                      *key;
        u8                      keylen;
@@ -1062,13 +1063,13 @@ struct tcp_md5sig_key {

 struct tcp4_md5sig_key {
        u8                      *key;
-       u16                     keylen;
+       u8                      keylen;
        __be32                  addr;
 };

 struct tcp6_md5sig_key {
        u8                      *key;
-       u16                     keylen;
+       u8                      keylen;
 #if 0
        u32                     scope_id;       /* XXX */
 #endif


Signed-off-by: Peter Lieven <pl@dlh.net>
Signed-off-by: Matthias M. Dellweg <2500@gmx.de>



