From: Christopher Zimmermann <madroach@zakweb.de>
Date: Sat, 03 Sep 2005 21:10:13 +0000
Subject: Sun mouse using 5-byte MSC protocol
Message-Id: <20050903211013.GA1200@sparc>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi, 

I use a Sun mouse which sends 5-byte MSC packets instead of the normal
3-byte ones. The current sermouse driver just drops the last two bytes
making the cursor move slow. I changed the driver to switch to the
5-byte protocol after dropping too many bytes.
Maybe someone knows a better method of probing for such mice. Please let
me know.
Unfortunately I don't have any "real" sun mouse sending 3-byte packets;
therefore I could not test if my modifications breaks support for those
sun mice.

Christopher
