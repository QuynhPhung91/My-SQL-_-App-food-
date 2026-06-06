module.exports = (req, res, next) => {
  if (!req.user) return res.status(401).json({ error: 'Unauthorized' });
  if (req.user.role === 'admin') return next();
  const targetId = parseInt(req.params.id, 10);
  if (req.user.id === targetId) return next();
  return res.status(403).json({ error: 'Forbidden' });
};
