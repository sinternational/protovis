HTML_FILES = \
	www/docs/anchor.html \
	www/docs/animation.html \
	www/docs/area.html \
	www/docs/bar.html \
	www/docs/chaining.html \
	www/docs/color.html \
	www/docs/data.html \
	www/docs/dot.html \
	www/docs/image.html \
	www/docs/index.html \
	www/docs/inheritance.html \
	www/docs/interaction.html \
	www/docs/invert.html \
	www/docs/label.html \
	www/docs/layout.html \
	www/docs/local.html \
	www/docs/line.html \
	www/docs/mark.html \
	www/docs/panel.html \
	www/docs/polar.html \
	www/docs/releases.html \
	www/docs/rule.html \
	www/docs/scale.html \
	www/docs/splom.html \
	www/docs/start.html \
	www/docs/wedge.html \
	www/ex/antibiotics-burtin.html \
	www/ex/arc.html \
	www/ex/area.html \
	www/ex/bar.html \
	www/ex/barley.html \
	www/ex/box-and-whisker.html \
	www/ex/browser-wars.html \
	www/ex/brush.html \
	www/ex/bubble.html \
	www/ex/bubbles.html \
	www/ex/bullet.html \
	www/ex/bzr.html \
	www/ex/caltrain.html \
	www/ex/candlestick.html \
	www/ex/cars.html \
	www/ex/cartogram.html \
	www/ex/cell.html \
	www/ex/choropleth.html \
	www/ex/clock.html \
	www/ex/crimea-rose.html \
	www/ex/dendrogram.html \
	www/ex/dot.html \
	www/ex/driving.html \
	www/ex/dymax.html \
	www/ex/error.html \
	www/ex/eyes.html \
	www/ex/flowers.html \
	www/ex/force-toggle.html \
	www/ex/force.html \
	www/ex/grid.html \
	www/ex/group.html \
	www/ex/heatmap.html \
	www/ex/histogram.html \
	www/ex/horizon.html \
	www/ex/hotel.html \
	www/ex/icicle.html \
	www/ex/indent.html \
	www/ex/index-chart.html \
	www/ex/jobs.html \
	www/ex/life.html \
	www/ex/line.html \
	www/ex/linear-date.html \
	www/ex/matrix.html \
	www/ex/minnesota.html \
	www/ex/napoleon.html \
	www/ex/nba.html \
	www/ex/nbody.html \
	www/ex/oakland.html \
	www/ex/pack.html \
	www/ex/pie.html \
	www/ex/point.html \
	www/ex/projection.html \
	www/ex/qqplot.html \
	www/ex/radial-cluster.html \
	www/ex/segmented.html \
	www/ex/sort.html \
	www/ex/sparklines.html \
	www/ex/splines.html \
	www/ex/stack.html \
	www/ex/stem-and-leaf.html \
	www/ex/stream.html \
	www/ex/sunburst.html \
	www/ex/symbol.html \
	www/ex/tipsy.html \
	www/ex/transform.html \
	www/ex/tree.html \
	www/ex/treemap.html \
	www/ex/unemployed.html \
	www/ex/waves.html \
	www/ex/weather.html \
	www/ex/wheat.html \
	www/ex/zoom.html \
	www/index.html

all: $(HTML_FILES) www/ex/syntax.css

%.d: %.m4 Makefile m4d.sh
	./m4d.sh $< > $@

include $(HTML_FILES:.html=.d)

PYGMENT = /Library/Pygments-1.1.1/pygmentize
PYGMENT_STYLE = trac

www/ex/syntax.css: Makefile
	$(PYGMENT) -f html -S $(PYGMENT_STYLE) > $@

%.html: %.m4 Makefile
	rm -f $@
	pushd $(dir $<) && m4 -P < $(notdir $<) > $(notdir $@) && popd
	chmod a-w $@

%.html.html: %.html Makefile
	$(PYGMENT) -f html -O style=$(PYGMENT_STYLE) -l html $(filter %.html,$^) > $@

%.js.html: %.js Makefile
	$(PYGMENT) -f html -O style=$(PYGMENT_STYLE) -l js $(filter %.js,$^) > $@

%.js.txt: %.js Makefile
	cat $(filter %.js,$^) > $@

%.java.html: %.java Makefile
	$(PYGMENT) -f html -O style=$(PYGMENT_STYLE) -l java $(filter %.java,$^) > $@

clean:
	rm -f $(HTML_FILES) $(HTML_FILES:.html=.d)
