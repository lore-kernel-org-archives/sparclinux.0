From: Joe Perches <joe@perches.com>
Date: Fri, 06 Nov 2015 18:32:55 +0000
Subject: [PATCH] checkpatch: Warn when casting constants to c90 int or longer types
Message-Id: <1446834775.14219.30.camel@perches.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151105.163959.1438115257720770769.davem@davemloft.net>
	 <CA+55aFwvFvsZuiURSfKuP85tcQgNUwj+bXdL9smZgMV8c++1EQ@mail.gmail.com>
	 <CA+55aFz54eqrSy0TM3JNLXzyHO-DjsTHBLTWY1HTeZSyMLf73A@mail.gmail.com>
In-Reply-To: <CA+55aFz54eqrSy0TM3JNLXzyHO-DjsTHBLTWY1HTeZSyMLf73A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Julia Lawall <julia.lawall@lip6.fr>

Linus Torvalds wrote:

> I can't but help to react that this:
>  #define IOMMU_ERROR_CODE       (~(unsigned long) 0)
> Not that this *matters*, but it's a bit odd to have to cast constants
> to perfectly regular C types.

So add a test that looks for constants that are cast to
standard C90 int or longer types and suggest using C90
"6.4.4.1 Integer constants" integer-suffixes instead.

Miscellanea:

o Add a --fix option too

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2d88cbf9..24cdeb0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -431,6 +431,28 @@ our @typeList = (
 	qr{${Ident}_handler_fn},
 	@typeListMisordered,
 );
+
+our $C90_int_types = qr{(?x:
+	long\s+long\s+int\s+(?:un)?signed|
+	long\s+long\s+(?:un)?signed\s+int|
+	long\s+long\s+(?:un)?signed|
+	(?:(?:un)?signed\s+)?long\s+long\s+int|
+	(?:(?:un)?signed\s+)?long\s+long|
+	int\s+long\s+long\s+(?:un)?signed|
+	int\s+(?:(?:un)?signed\s+)?long\s+long|
+
+	long\s+int\s+(?:un)?signed|
+	long\s+(?:un)?signed\s+int|
+	long\s+(?:un)?signed|
+	(?:(?:un)?signed\s+)?long\s+int|
+	(?:(?:un)?signed\s+)?long|
+	int\s+long\s+(?:un)?signed|
+	int\s+(?:(?:un)?signed\s+)?long|
+
+	int\s+(?:un)?signed|
+	(?:(?:un)?signed\s+)?int
+)};
+
 our @typeListFile = ();
 our @typeListWithAttr = (
 	@typeList,
@@ -5240,6 +5262,26 @@ sub process {
 			}
 		}
 
+# check for cast of C90 native int or longer types constants
+		if ($line =~ /(\(\s*$C90_int_types\s*\)\s*)($Constant)\b/) {
+			my $cast = $1;
+			my $const = $2;
+			if (WARN("TYPECAST_INT_CONSTANT",
+				 "Unnecessary typecast of c90 int constant\n" . $herecurr) &&
+			    $fix) {
+				my $suffix = "";
+				my $newconst = $const;
+				$newconst =~ s/${Int_type}$//;
+				$suffix .= 'U' if ($cast =~ /\bunsigned\b/);
+				if ($cast =~ /\blong\s+long\b/) {
+					$suffix .= 'LL';
+				} elsif ($cast =~ /\blong\b/) {
+					$suffix .= 'L';
+				}
+				$fixed[$fixlinenr] =~ s/\Q$cast\E$const\b/$newconst$suffix/;
+			}
+		}
+
 # check for sizeof(&)
 		if ($line =~ /\bsizeof\s*\(\s*\&/) {
 			WARN("SIZEOF_ADDRESS",
